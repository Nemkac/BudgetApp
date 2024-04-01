/*
Copyright 2017 - 2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at
    http://aws.amazon.com/apache2.0/
or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
*/

/* Amplify Params - DO NOT EDIT
	ENV
	REGION
	dev
	prod
Amplify Params - DO NOT EDIT */
const { randomUUID } = require('crypto');
const { predictCategory } = require('./utils');
const { DynamoDBClient } = require('@aws-sdk/client-dynamodb');
const {
  DeleteCommand,
  DynamoDBDocumentClient,
  GetCommand,
  PutCommand,
  QueryCommand,
} = require('@aws-sdk/lib-dynamodb');
const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware');
const bodyParser = require('body-parser');
const express = require('express');

const ddbClient = new DynamoDBClient({ region: process.env.TABLE_REGION });
const ddbDocClient = DynamoDBDocumentClient.from(ddbClient);

let transactionsTableName = 'transactionsdb';
let categoriesTableName = 'categoriesdb';
if (process.env.ENV && process.env.ENV !== 'NONE') {
  transactionsTableName = transactionsTableName + '-' + process.env.ENV;
  categoriesTableName = categoriesTableName + '-' + process.env.ENV;
}

const userIdPresent = true;
const partitionKeyName = 'userId';
const partitionKeyType = 'S';
const sortKeyName = 'creationDateTransactionId';
const sortKeyType = 'S';
const hasSortKey = sortKeyName !== '';
const path = '/transactions';
const UNAUTH = 'UNAUTH';
const hashKeyPath = '/:' + partitionKeyName;
const sortKeyPath = hasSortKey ? '/:' + sortKeyName : '';

// declare a new express app
const app = express();
app.use(bodyParser.json());
app.use(awsServerlessExpressMiddleware.eventContext());

// Enable CORS for all methods
app.use(function (req, res, next) {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', '*');
  next();
});

// convert url string param to expected Type
const convertUrlType = (param, type) => {
  switch (type) {
    case 'N':
      return Number.parseInt(param);
    default:
      return param;
  }
};

// get userId from request
function getUserId(req) {
  const provider =
    req?.apiGateway?.event?.requestContext?.identity
      ?.cognitoAuthenticationProvider;

  const userId = provider.split(':CognitoSignIn:')[1];

  return userId || UNAUTH;
}

/************************************
 * HTTP Get method to query objects *
 ************************************/

app.get(path + hashKeyPath, async function (req, res) {
  const userId = getUserId(req);
  const creationDate = req.query.creationDate;

  const condition = {};
  condition[partitionKeyName] = {
    ComparisonOperator: 'EQ',
    AttributeValueList: [userId || UNAUTH],
  };

  if (creationDate) {
    condition[sortKeyName] = {
      ComparisonOperator: 'BEGINS_WITH',
      AttributeValueList: [creationDate],
    };
  }

  let queryParams = {
    TableName: transactionsTableName,
    KeyConditions: condition,
  };

  try {
    const data = await ddbDocClient.send(new QueryCommand(queryParams));
    const transactionWithCategory = await Promise.all(
      data.Items.map(async (transaction) => {
        const categoryId = transaction.categoryId;

        const categoryParams = {
          TableName: categoriesTableName,
          Key: { userId, categoryId },
        };

        const categoryData = await ddbDocClient.send(
          new GetCommand(categoryParams)
        );

        return { ...transaction, category: categoryData.Item };
      })
    );

    res.json(transactionWithCategory);
  } catch (err) {
    res.statusCode = 500;
    res.json({ error: 'Could not load items: ' + err.message });
  }
});

/******************************************************
 * HTTP Get method to find closest category by merchant *
 ******************************************************/

app.get(
  path + hashKeyPath + '/get-closest-category',
  async function (req, res) {
    const userId = getUserId(req);
    const merchantName = req.query.merchantName;

    const condition = {};
    condition[partitionKeyName] = {
      ComparisonOperator: 'EQ',
      AttributeValueList: [userId || UNAUTH],
    };

    let queryParams = {
      TableName: transactionsTableName,
      KeyConditions: condition,
    };

    try {
      const data = await ddbDocClient.send(new QueryCommand(queryParams));
      const matchedCategory = predictCategory(data.Items, merchantName);

      res.json(matchedCategory);
    } catch (err) {
      res.statusCode = 500;
      res.json({ error: 'Could not load items: ' + err.message });
    }
  }
);

/*****************************************
 * HTTP Get method for get single object *
 *****************************************/

app.get(
  path + '/object' + hashKeyPath + sortKeyPath,
  async function (req, res) {
    const userId =
      req.apiGateway.event.requestContext.identity.cognitoAuthenticationProvider.split(
        ':CognitoSignIn:'
      )[1];

    const params = {};
    if (userIdPresent && req.apiGateway) {
      params[partitionKeyName] = userId || UNAUTH;
    } else {
      params[partitionKeyName] = req.params[partitionKeyName];
      try {
        params[partitionKeyName] = convertUrlType(
          req.params[partitionKeyName],
          partitionKeyType
        );
      } catch (err) {
        res.statusCode = 500;
        res.json({ error: 'Wrong column type ' + err });
      }
    }
    if (hasSortKey) {
      try {
        params[sortKeyName] = convertUrlType(
          req.params[sortKeyName],
          sortKeyType
        );
      } catch (err) {
        res.statusCode = 500;
        res.json({ error: 'Wrong column type ' + err });
      }
    }

    let getItemParams = {
      TableName: transactionsTableName,
      Key: params,
    };

    try {
      const transactionData = await ddbDocClient.send(
        new GetCommand(getItemParams)
      );
      if (transactionData.Item) {
        const categoryParams = {
          TableName: categoriesTableName,
          Key: { userId, categoryId: transactionData.Item.categoryId },
        };

        const categoryData = await ddbDocClient.send(
          new GetCommand(categoryParams)
        );

        if (categoryData.Item) {
          const transactionWithCategory = {
            ...transactionData.Item,
            category: categoryData.Item,
          };

          res.json(transactionWithCategory);
        } else {
          res.json(transactionData);
        }
      } else {
        res.json(transactionData);
      }
    } catch (err) {
      res.statusCode = 500;
      res.json({ error: 'Could not load items: ' + err.message });
    }
  }
);

/************************************
 * HTTP put method for updating object *
 *************************************/

app.put(path, async function (req, res) {
  const userId = getUserId(req);
  const transactionId = randomUUID();

  if (userIdPresent) {
    req.body['userId'] = userId || UNAUTH;
  }

  // Delete existing transaction
  let deleteItemParams = {
    TableName: transactionsTableName,
    Key: {
      userId,
      creationDateTransactionId: req.body.creationDateTransactionId,
    },
  };

  try {
    await ddbDocClient.send(new DeleteCommand(deleteItemParams));
  } catch (err) {
    res.statusCode = 500;
    res.json({ error: 'Could not delete transaction: ' + err.message });
    return;
  }

  // Create new transaction with the updated data
  const updatedTransaction = {
    userId,
    creationDateTransactionId: `${req.body?.creationDate}__${transactionId}`,
    amount: req.body.amount,
    categoryId: req.body.category.categoryId,
    address: req.body?.address || '',
    description: req.body?.description || '',
    merchantName: req.body?.merchantName || '',
  };

  let putItemParams = {
    TableName: transactionsTableName,
    Item: updatedTransaction,
  };

  try {
    let data = await ddbDocClient.send(new PutCommand(putItemParams));
    res.json({
      success: 'Transaction updated successfully!',
      url: req.url,
      data: data,
    });
  } catch (err) {
    res.statusCode = 500;
    res.json({ error: err, url: req.url, body: req.body });
  }
});

/************************************
 * HTTP post method for insert object *
 *************************************/

app.post(path, async function (req, res) {
  const userId = getUserId(req);
  const transactionId = randomUUID();
  const creationDate = req.body.creationDate;

  const transaction = {
    userId,
    creationDateTransactionId: `${creationDate}__${transactionId}`,
    amount: req.body.amount,
    categoryId: req.body.categoryId,
    address: req.body?.address || '',
    description: req.body?.description || '',
    merchantName: req.body?.merchantName || '',
  };

  let putItemParams = {
    TableName: transactionsTableName,
    Item: transaction,
  };
  try {
    let data = await ddbDocClient.send(new PutCommand(putItemParams));
    res.json({ success: 'post call succeed!', url: req.url, data: data });
  } catch (err) {
    res.statusCode = 500;
    res.json({ error: err, url: req.url, body: req.body });
  }
});

/**************************************
 * HTTP remove method to delete object *
 ***************************************/

app.delete(
  path + '/object' + hashKeyPath + sortKeyPath,
  async function (req, res) {
    const params = {};
    if (userIdPresent && req.apiGateway) {
      params[partitionKeyName] = getUserId(req);
    } else {
      params[partitionKeyName] = req.params[partitionKeyName];
      try {
        params[partitionKeyName] = convertUrlType(
          req.params[partitionKeyName],
          partitionKeyType
        );
      } catch (err) {
        res.statusCode = 500;
        res.json({ error: 'Wrong column type ' + err });
      }
    }
    if (hasSortKey) {
      try {
        params[sortKeyName] = convertUrlType(
          req.params[sortKeyName],
          sortKeyType
        );
      } catch (err) {
        res.statusCode = 500;
        res.json({ error: 'Wrong column type ' + err });
      }
    }

    let removeItemParams = {
      TableName: transactionsTableName,
      Key: params,
    };

    try {
      let data = await ddbDocClient.send(new DeleteCommand(removeItemParams));
      res.json({ url: req.url, data: data });
    } catch (err) {
      res.statusCode = 500;
      res.json({ error: err, url: req.url });
    }
  }
);

app.listen(3000, function () {
  console.log('App started');
});

// Export the app object. When executing the application local this does nothing. However,
// to port it to AWS Lambda we will create a wrapper around that will load the app from
// this file
module.exports = app;

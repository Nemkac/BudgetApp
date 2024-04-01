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
const { DynamoDBClient } = require('@aws-sdk/client-dynamodb');
const {
  DeleteCommand,
  DynamoDBDocumentClient,
  GetCommand,
  PutCommand,
  QueryCommand,
  BatchWriteCommand,
} = require('@aws-sdk/lib-dynamodb');
const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware');
const bodyParser = require('body-parser');
const express = require('express');

const ddbClient = new DynamoDBClient({ region: process.env.TABLE_REGION });
const ddbDocClient = DynamoDBDocumentClient.from(ddbClient);

let budgetsTableName = 'budgetsdb';
let transactionsTableName = 'transactionsdb';
let tableName = 'categoriesdb';
if (process.env.ENV && process.env.ENV !== 'NONE') {
  tableName = tableName + '-' + process.env.ENV;
  budgetsTableName = budgetsTableName + '-' + process.env.ENV;
  transactionsTableName = transactionsTableName + '-' + process.env.ENV;
}

const userIdPresent = true;
const partitionKeyName = 'userId';
const partitionKeyType = 'S';
const sortKeyName = 'categoryId';
const sortKeyType = 'S';
const hasSortKey = sortKeyName !== '';
const path = '/categories';
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

  const condition = {};
  condition[partitionKeyName] = {
    ComparisonOperator: 'EQ',
  };

  if (userIdPresent && req.apiGateway) {
    condition[partitionKeyName]['AttributeValueList'] = [userId || UNAUTH];
  } else {
    try {
      condition[partitionKeyName]['AttributeValueList'] = [
        convertUrlType(req.params[partitionKeyName], partitionKeyType),
      ];
    } catch (err) {
      res.statusCode = 500;
      res.json({ error: 'Wrong column type ' + err });
    }
  }

  let queryParams = {
    TableName: tableName,
    KeyConditions: condition,
  };

  try {
    const data = await ddbDocClient.send(new QueryCommand(queryParams));
    res.json(data.Items);
  } catch (err) {
    res.statusCode = 500;
    res.json({ error: 'Could not load items: ' + err.message });
  }
});

/*****************************************
 * HTTP Get method for get single object *
 *****************************************/

app.get(
  path + '/object' + hashKeyPath + sortKeyPath,
  async function (req, res) {
    const userId = getUserId(req);

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
      TableName: tableName,
      Key: params,
    };

    try {
      const data = await ddbDocClient.send(new GetCommand(getItemParams));
      if (data.Item) {
        res.json(data.Item);
      } else {
        res.json(data);
      }
    } catch (err) {
      res.statusCode = 500;
      res.json({ error: 'Could not load items: ' + err.message });
    }
  }
);

/************************************
 * HTTP put method for insert object *
 *************************************/

app.put(path, async function (req, res) {
  const userId = getUserId(req);

  if (userIdPresent) {
    req.body['userId'] = userId || UNAUTH;
  }

  let putItemParams = {
    TableName: tableName,
    Item: req.body,
  };
  try {
    let data = await ddbDocClient.send(new PutCommand(putItemParams));
    res.json({ success: 'put call succeed!', url: req.url, data: data });
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

  if (userIdPresent) {
    req.body['userId'] = userId || UNAUTH;
  }

  const categoryId = randomUUID();
  const category = req.body;

  const updatedCateogry = {
    ...category,
    categoryId,
  };

  let putItemParams = {
    TableName: tableName,
    Item: updatedCateogry,
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
    const userId = getUserId(req);
    const categoryId = req.params[sortKeyName];

    const params = {};
    params[partitionKeyName] = userId || UNAUTH;

    if (hasSortKey) {
      try {
        params[sortKeyName] = convertUrlType(
          req.params[sortKeyName],
          sortKeyType
        );
      } catch (err) {
        res.statusCode = 500;
        res.json({ error: 'Wrong column type ' + err });
        return;
      }
    }

    try {
      const queryBudgetsParams = {
        TableName: budgetsTableName,
        IndexName: 'userId-categoryId-index',
        KeyConditionExpression: 'userId = :userId and categoryId = :categoryId',
        ExpressionAttributeValues: {
          ':userId': userId,
          ':categoryId': categoryId,
        },
      };

      const budgetsData = await ddbDocClient.send(
        new QueryCommand(queryBudgetsParams)
      );

      const queryTransactionsParams = {
        TableName: transactionsTableName,
        IndexName: 'userId-categoryId-index',
        KeyConditionExpression: 'userId = :userId and categoryId = :categoryId',
        ExpressionAttributeValues: {
          ':userId': userId,
          ':categoryId': categoryId,
        },
      };

      const transactionsData = await ddbDocClient.send(
        new QueryCommand(queryTransactionsParams)
      );

      // Check if budgets exist before attempting to delete
      if (budgetsData.Items.length > 0) {
        const budgetBatchDeleteRequests = budgetsData.Items.map((item) => ({
          DeleteRequest: {
            Key: {
              userId: item.userId,
              creationDateBudgetId: item.creationDateBudgetId,
            },
          },
        }));

        const batchDeleteBudgetsParams = {
          RequestItems: {
            [budgetsTableName]: budgetBatchDeleteRequests,
          },
        };

        await ddbDocClient.send(
          new BatchWriteCommand(batchDeleteBudgetsParams)
        );
      }

      // Check if transactions exist before attempting to delete
      if (transactionsData.Items.length > 0) {
        const transactionBatchDeleteRequests = transactionsData.Items.map(
          (item) => ({
            DeleteRequest: {
              Key: {
                userId: item.userId,
                creationDateTransactionId: item.creationDateTransactionId,
              },
            },
          })
        );

        const batchDeleteTransactionsParams = {
          RequestItems: {
            [transactionsTableName]: transactionBatchDeleteRequests,
          },
        };

        await ddbDocClient.send(
          new BatchWriteCommand(batchDeleteTransactionsParams)
        );
      }

      const deleteCategoryParams = {
        TableName: tableName,
        Key: params,
      };

      await ddbDocClient.send(new DeleteCommand(deleteCategoryParams));

      res.json({ success: 'Deletion successful', url: req.url });
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

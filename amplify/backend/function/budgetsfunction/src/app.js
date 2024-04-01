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
const { format } = require('date-fns');
const { randomUUID } = require('crypto');
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

let budgetsTableName = 'budgetsdb';
let categoriesTableName = 'categoriesdb';
if (process.env.ENV && process.env.ENV !== 'NONE') {
  budgetsTableName = budgetsTableName + '-' + process.env.ENV;
  categoriesTableName = categoriesTableName + '-' + process.env.ENV;
}

const userIdPresent = true;
const partitionKeyName = 'userId';
const partitionKeyType = 'S';
const sortKeyName = 'creationDateBudgetId';
const sortKeyType = 'S';
const hasSortKey = sortKeyName !== '';
const path = '/budgets';
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
    condition['creationDateBudgetId'] = {
      ComparisonOperator: 'BEGINS_WITH',
      AttributeValueList: [creationDate],
    };
  }

  let queryParams = {
    TableName: budgetsTableName,
    KeyConditions: condition,
  };

  try {
    const data = await ddbDocClient.send(new QueryCommand(queryParams));
    const budgetWithCategory = await Promise.all(
      data.Items.map(async (budget) => {
        const categoryId = budget.categoryId;

        const categoryParams = {
          TableName: categoriesTableName,
          Key: { userId, categoryId },
        };

        const categoryData = await ddbDocClient.send(
          new GetCommand(categoryParams)
        );

        return { ...budget, category: categoryData.Item };
      })
    );

    res.json(budgetWithCategory);
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
    const params = {};
    if (userIdPresent && req.apiGateway) {
      params[partitionKeyName] =
        req.apiGateway.event.requestContext.identity.cognitoIdentityId ||
        UNAUTH;
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
      TableName: budgetsTableName,
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
  const budget = {
    userId: req.body.userId,
    creationDateBudgetId: req.body.creationDateBudgetId,
    amount: req.body.amount,
    categoryId: req.body.category.categoryId,
    budgetFeedback: req.body.budgetFeedback,
    repeatInterval: req.body.repeatInterval,
  };

  let putItemParams = {
    TableName: budgetsTableName,
    Item: budget,
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
  const budgetId = randomUUID();
  const currentDate = new Date();
  const creationDate = format(currentDate, 'yyyy-MM-dd');

  const budget = {
    userId,
    creationDateBudgetId: `${creationDate}__${budgetId}`,
    amount: req.body.amount,
    categoryId: req.body.categoryId,
    budgetFeedback: req.body.budgetFeedback,
    repeatInterval: req.body.repeatInterval,
  };

  let putItemParams = {
    TableName: budgetsTableName,
    Item: budget,
  };

  try {
    let data = await ddbDocClient.send(new PutCommand(putItemParams));
    res.json({ success: 'post call succeed!', url: req.url, data: data });
  } catch (err) {
    res.statusCode = 500;
    res.json({ error: err, url: req.url, body: req.body });
  }
});

/****************************************************
 * HTTP post method for insert uncategorized budget *
 ****************************************************/

app.post(`${path}/uncategorized-budget`, async function (req, res) {
  const userId = getUserId(req);

  try {
    const categoryId = randomUUID();
    const category = {
      userId,
      categoryId,
      name: req.body.name,
      color: req.body.color,
      icon: req.body.icon,
      type: req.body?.type || 'Expense',
      favorite: false,
    };

    let categoryPutItemParams = {
      TableName: categoriesTableName,
      Item: category,
    };

    await ddbDocClient.send(new PutCommand(categoryPutItemParams));

    // Now create the budget with the new categoryId
    const budgetId = randomUUID();
    const currentDate = new Date();
    const creationDate = format(currentDate, 'yyyy-MM-dd');

    const budget = {
      userId,
      creationDateBudgetId: `${creationDate}__${budgetId}`,
      categoryId,
      amount: req.body.amount,
      budgetFeedback: req.body.budgetFeedback,
      repeatInterval: req.body.repeatInterval,
    };

    let budgetPutItemParams = {
      TableName: budgetsTableName,
      Item: budget,
    };

    let data = await ddbDocClient.send(new PutCommand(budgetPutItemParams));

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
      TableName: budgetsTableName,
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

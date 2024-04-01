const { randomUUID } = require('crypto');
const { getInitialCategories } = require('./categories');
const { DynamoDBClient } = require('@aws-sdk/client-dynamodb');
const {
  BatchWriteCommand,
  DynamoDBDocumentClient,
} = require('@aws-sdk/lib-dynamodb');

const ddbClient = new DynamoDBClient({ region: process.env.TABLE_REGION });
const ddbDocClient = DynamoDBDocumentClient.from(ddbClient);

let categoriesTableName = 'categoriesdb';
if (process.env.ENV && process.env.ENV !== 'NONE') {
  categoriesTableName = categoriesTableName + '-' + process.env.ENV;
}

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
  const userId = event.userName;
  const triggerSource = event?.triggerSource;

  if (triggerSource !== 'PostConfirmation_ConfirmSignUp') {
    console.log('Not a ConfirmSignUp trigger. Skipping initialization.');
    return event;
  }
  const initialCategories = getInitialCategories().map((category) => ({
    ...category,
    userId,
    categoryId: randomUUID(),
  }));

  const putRequests = initialCategories.map((category) => ({
    PutRequest: {
      Item: category,
    },
  }));

  const batchWriteParams = {
    RequestItems: {
      [categoriesTableName]: putRequests,
    },
  };

  try {
    await ddbDocClient.send(new BatchWriteCommand(batchWriteParams));

    return event;
  } catch (error) {
    console.error('Error creating categories: ', error);

    return event;
  }
};

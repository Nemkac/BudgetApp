/* Amplify Params - DO NOT EDIT
	ENV
	REGION
	dev
	prod
Amplify Params - DO NOT EDIT */
const { DynamoDBClient } = require('@aws-sdk/client-dynamodb');
const {
  PutCommand,
  QueryCommand,
  DynamoDBDocumentClient,
} = require('@aws-sdk/lib-dynamodb');
const { randomUUID } = require('crypto');
const {
  format,
  subYears,
  subMonths,
  startOfYear,
  startOfMonth,
} = require('date-fns');

const ddbClient = new DynamoDBClient({ region: process.env.TABLE_REGION });
const ddbDocClient = DynamoDBDocumentClient.from(ddbClient);

let budgetsTableName = 'budgetsdb';
if (process.env.ENV && process.env.ENV !== 'NONE') {
  budgetsTableName = budgetsTableName + '-' + process.env.ENV;
}

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
  try {
    const currentDate = new Date();
    const isMonthlyTrigger = event.triggerType === 'monthly';
    let queryDate;

    if (isMonthlyTrigger) {
      const firstDayOfPreviousMonth = startOfMonth(subMonths(currentDate, 1));
      queryDate = format(firstDayOfPreviousMonth, 'yyyy-MM');
    } else {
      const firstDayOfPreviousYear = startOfYear(subYears(currentDate, 1));
      queryDate = format(firstDayOfPreviousYear, 'yyyy');
    }

    // Query for budgets with 'Monthly' or 'Yearly' repeat intervals
    const repeatedBudgets = await queryRepeatedBudgets(
      queryDate,
      isMonthlyTrigger
    );

    // Process each budget and create new ones for the current period
    const creationPromises = repeatedBudgets.map((budget) =>
      createNewBudget(budget, currentDate)
    );
    await Promise.all(creationPromises);

    console.log('Processed budgets successfully.');

    return {
      statusCode: 200,
      body: JSON.stringify({ message: 'Budgets processed successfully' }),
    };
  } catch (error) {
    console.error('Error processing budgets: ', error);

    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Error processing budgets' }),
    };
  }
};

async function queryRepeatedBudgets(queryDate, isMonthlyTrigger) {
  const repeatInterval = isMonthlyTrigger ? 'Monthly' : 'Yearly';

  const queryParams = {
    TableName: budgetsTableName,
    IndexName: 'repeatInterval-creationDateBudgetId-index',
    KeyConditionExpression: '#ri = :interval and begins_with(#cd, :date)',
    ExpressionAttributeNames: {
      '#ri': 'repeatInterval',
      '#cd': 'creationDateBudgetId',
    },
    ExpressionAttributeValues: {
      ':interval': repeatInterval,
      ':date': queryDate,
    },
  };

  const data = await ddbDocClient.send(new QueryCommand(queryParams));

  return data.Items || [];
}

async function createNewBudget(budget, currentDate) {
  const newBudgetId = randomUUID();
  const creationDate = format(currentDate, 'yyyy-MM-dd');
  const newBudget = {
    ...budget,
    creationDateBudgetId: `${creationDate}__${newBudgetId}`,
  };

  let putItemParams = {
    TableName: budgetsTableName,
    Item: newBudget,
  };

  return ddbDocClient.send(new PutCommand(putItemParams));
}

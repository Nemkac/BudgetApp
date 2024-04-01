const amplifyconfig = '''{
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "budgetmanager": {
                    "endpointType": "REST",
                    "endpoint": "https://tqtdyh7b97.execute-api.eu-north-1.amazonaws.com/dev",
                    "region": "eu-north-1",
                    "authorizationType": "AWS_IAM"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-north-1:390bce94-9c87-40c6-a74f-af8b07a9b641",
                            "Region": "eu-north-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-north-1_vOrsZ6grq",
                        "AppClientId": "2f4p62f725rim0dvi88v35sa38",
                        "Region": "eu-north-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "budgetmanager-dev.auth.eu-north-1.amazoncognito.com",
                            "AppClientId": "2f4p62f725rim0dvi88v35sa38",
                            "SignInRedirectURI": "cutapp://",
                            "SignOutRedirectURI": "cutapp://",
                            "Scopes": [
                                "phone",
                                "email",
                                "openid",
                                "profile",
                                "aws.cognito.signin.user.admin"
                            ]
                        },
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "signupAttributes": [
                            "EMAIL",
                            "NAME"
                        ],
                        "socialProviders": [
                            "GOOGLE"
                        ],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "DynamoDBObjectMapper": {
                    "Default": {
                        "Region": "eu-north-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsDynamoDbStoragePlugin": {
                "partitionKeyName": "userId",
                "sortKeyName": "creationDateTransactionId",
                "sortKeyType": "S",
                "region": "eu-north-1",
                "arn": "arn:aws:dynamodb:eu-north-1:597028766537:table/transactionsdb-dev",
                "streamArn": "arn:aws:dynamodb:eu-north-1:597028766537:table/transactionsdb-dev/stream/2023-12-11T10:13:43.533",
                "partitionKeyType": "S",
                "name": "transactionsdb-dev"
            }
        }
    }
}''';
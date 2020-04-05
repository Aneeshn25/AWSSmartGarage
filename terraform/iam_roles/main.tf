provider "aws" {
  region = "${var.AWS_REGION}"
  version = "~> 2.4"
}

resource "aws_iam_role" "LambdaDynamoAPI_Role" {
  name = "LambdaDynamoAPI_Role"
  description = "Allows Lambda functions to call Dynamodb table and cloudwatch on your behalf"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "apigateway.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Name = "LambdaDynamoAPI_Role"
  }
}


resource "aws_iam_role_policy" "Execute_Lambda" {
  name = "Execute_Lambda"
  role = "${aws_iam_role.LambdaDynamoAPI_Role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "lambda:InvokeFunction",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "dynamoGetScanQueryItemRole" {
  name = "dynamoGetScanQueryItemRole"
  role = "${aws_iam_role.LambdaDynamoAPI_Role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:GetItem",
                "dynamodb:Scan",
                "dynamodb:Query"
            ],
            "Resource": "arn:aws:dynamodb:${var.AWS_REGION}:${var.AWS_ACCOUNT}:table/${var.table_name}"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "stepFunctionSmartGaragePolicy" {
  name = "stepFunctionSmartGaragePolicy"
  role = "${aws_iam_role.LambdaDynamoAPI_Role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "states:StartExecution",
            "Resource": "arn:aws:states:${var.AWS_REGION}:${var.AWS_ACCOUNT}:stateMachine:smartGarage"
        }
    ]
}
EOF
}



resource "aws_iam_role_policy" "CloudWatchLogs" {
  name = "CloudWatchLogs"
  role = "${aws_iam_role.LambdaDynamoAPI_Role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents",
        "logs:GetLogEvents",
        "logs:FilterLogEvents"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Role for Step Function
resource "aws_iam_role" "StepFunctionSmartGarage_Role" {
  name = "StepFunctionSmartGarage_Role"
  description = "Allows Step function to call Lambda Function on your behalf"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "states.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Name = "StepFunctionSmartGarage_Role"
  }
}

resource "aws_iam_role_policy" "Execute_StepLambda" {
  name = "Execute_StepLambda"
  role = "${aws_iam_role.StepFunctionSmartGarage_Role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Resource": [
                "arn:aws:lambda:${var.AWS_REGION}:${var.AWS_ACCOUNT}:function:${var.AutoCloseFunctionName}:*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Resource": [
                "arn:aws:lambda:${var.AWS_REGION}:${var.AWS_ACCOUNT}:function:${var.AutoCloseFunctionName}"
            ]
        }
    ]
}
EOF
}
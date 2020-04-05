provider "aws" {
  region = "${var.AWS_REGION}"
  version = "~> 2.4"
}

// -------- Data Remote State VPC --------- //
data "terraform_remote_state" "smart_garage_iam_role" {
  backend = "s3"

  config = {
    bucket   = "${var.bucket_remote_state}"
    key      = "env:/${var.workspace}/iam_roles/terraform.tfstate"
    region   = "${var.bucket_region}"
    role_arn = "${var.tf_mgmt_role_arn}"
  }
}

resource "aws_lambda_function" "getIdsFromSmartGarage" {
  role             = "${data.terraform_remote_state.smart_garage_iam_role.outputs.LambdaDynamoAPI_arn}"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  filename         = "getIdsFromSmartGarage/lambda_function.zip"
  function_name    = "getIdsFromSmartGarage"
  source_code_hash = "${data.archive_file.lambdaGetIds.output_base64sha256}"
  depends_on       = ["aws_cloudwatch_log_group.lambdacloudwatchlogs"]

  environment {
    variables = {
      simple = "API"
    }
  }
}

resource "aws_lambda_function" "getIdItemsFromSmartGarage" {
  role             = "${data.terraform_remote_state.smart_garage_iam_role.outputs.LambdaDynamoAPI_arn}"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  filename         = "getIdItemsFromSmartGarage/lambda_function.zip"
  function_name    = "getIdItemsFromSmartGarage"
  source_code_hash = "${data.archive_file.lambdaGetIdItems.output_base64sha256}"
  depends_on       = ["aws_cloudwatch_log_group.lambdacloudwatchlogs"]

  environment {
    variables = {
      simple = "API"
    }
  }
}

resource "aws_lambda_function" "postItemsToSmartGarage" {
  role             = "${data.terraform_remote_state.smart_garage_iam_role.outputs.LambdaDynamoAPI_arn}"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  filename         = "postItemsToSmartGarage/lambda_function.zip"
  function_name    = "postItemsToSmartGarage"
  source_code_hash = "${data.archive_file.lambdaPostItems.output_base64sha256}"
  depends_on       = ["aws_cloudwatch_log_group.lambdacloudwatchlogs"]

  environment {
    variables = {
      simple = "API"
    }
  }
}


resource "aws_lambda_function" "AutoCloseFunction" {
  role             = "${data.terraform_remote_state.smart_garage_iam_role.outputs.LambdaDynamoAPI_arn}"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  filename         = "AutoCloseFunction/lambda_function.zip"
  function_name    = "AutoCloseFunction"
  source_code_hash = "${data.archive_file.AutoCloseFunction.output_base64sha256}"
  depends_on       = ["aws_cloudwatch_log_group.lambdacloudwatchlogs"]

  environment {
    variables = {
      simple = "API"
    }
  }
}

resource "aws_cloudwatch_log_group" "lambdacloudwatchlogs" {
  name              = "lambdacloudwatchlogs"
  retention_in_days = 30
}
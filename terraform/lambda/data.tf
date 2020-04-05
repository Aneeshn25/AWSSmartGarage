data "archive_file" "lambdaGetIds" {
  type        = "zip"
  source_file = "${path.module}/getIdsFromSmartGarage/lambda_function.py"
  output_path = "${path.module}/getIdsFromSmartGarage/lambda_function.zip"
}

data "archive_file" "lambdaGetIdItems" {
  type        = "zip"
  source_file = "${path.module}/getIdItemsFromSmartGarage/lambda_function.py"
  output_path = "${path.module}/getIdItemsFromSmartGarage/lambda_function.zip"
}

data "archive_file" "lambdaPostItems" {
  type        = "zip"
  source_file = "${path.module}/postItemsToSmartGarage/lambda_function.py"
  output_path = "${path.module}/postItemsToSmartGarage/lambda_function.zip"
}

data "archive_file" "AutoCloseFunction" {
  type        = "zip"
  source_file = "${path.module}/AutoCloseFunction/lambda_function.py"
  output_path = "${path.module}/AutoCloseFunction/lambda_function.zip"
}

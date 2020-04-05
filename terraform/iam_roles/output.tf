output "LambdaDynamoAPI_name" {
  value       = "${join("", aws_iam_role.LambdaDynamoAPI_Role.*.name)}"
  description = "The name of the IAM role created"
}

output "LambdaDynamoAPI_id" {
  value       = "${join("", aws_iam_role.LambdaDynamoAPI_Role.*.unique_id)}"
  description = "The stable and unique string identifying the role"
}

output "LambdaDynamoAPI_arn" {
  value       = "${join("", aws_iam_role.LambdaDynamoAPI_Role.*.arn)}"
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "StepFunctionSmartGarage_arn" {
  value       = "${join("", aws_iam_role.StepFunctionSmartGarage_Role.*.arn)}"
  description = "The Amazon Resource Name (ARN) specifying the role"
}
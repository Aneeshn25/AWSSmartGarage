output "table_name" {
  value       = join("", aws_dynamodb_table.garrageDoor.*.name)
  description = "DynamoDB table name"
}

output "table_id" {
  value       = join("", aws_dynamodb_table.garrageDoor.*.id)
  description = "DynamoDB table ID"
}

output "table_arn" {
  value       = join("", aws_dynamodb_table.garrageDoor.*.arn)
  description = "DynamoDB table ARN"
}
provider "aws" {
  region = "${var.AWS_REGION}"
  version = "~> 2.4"
}

#Creating a Dynamodb table garrageDoor
resource "aws_dynamodb_table" "garrageDoor" {
  name           = "${var.table_name}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "${var.hash}"

  attribute {
    name = "id"
    type = "S"
  }


  tags = {
    Name        = "dynamodb-smart-garage-table"
    Environment = "production"
  }
}

#inserting an item
resource "aws_dynamodb_table_item" "init-items" {
  table_name = "${aws_dynamodb_table.garrageDoor.name}"
  hash_key = "${aws_dynamodb_table.garrageDoor.hash_key}"
  item = "${data.template_file.items.rendered}"
}

provider "aws" {
  region = "${var.AWS_REGION}"
  version = "~> 2.4"
}

// -------- Data Remote State LAMBDA --------- //
data "terraform_remote_state" "smart_garage_lambda" {
  backend = "s3"

  config = {
    bucket   = "${var.bucket_remote_state}"
    key      = "env:/${var.workspace}/lambda/terraform.tfstate"
    region   = "${var.bucket_region}"
    role_arn = "${var.tf_mgmt_role_arn}"
  }
}

// -------- Data Remote State IAM ROLE --------- //
data "terraform_remote_state" "smart_garage_iam_role" {
  backend = "s3"

  config = {
    bucket   = "${var.bucket_remote_state}"
    key      = "env:/${var.workspace}/iam_roles/terraform.tfstate"
    region   = "${var.bucket_region}"
    role_arn = "${var.tf_mgmt_role_arn}"
  }
}

# step function definition template
data "template_file" "sfn-definition" {
  template = "${file(var.step_function_definition_file)}"
  vars = {
    lambda-name = "${data.terraform_remote_state.smart_garage_lambda.outputs.AutoCloseFunction_arn}"
  }
}

resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "${var.step_function_name}"
  role_arn = "${data.terraform_remote_state.smart_garage_iam_role.outputs.StepFunctionSmartGarage_arn}"

  definition = "${data.template_file.sfn-definition.rendered}"
}
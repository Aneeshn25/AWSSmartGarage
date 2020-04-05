variable "AWS_REGION" { default = "us-east-2" }
variable "AWS_ACCOUNT" { default = "01234567891" }

variable "tf_mgmt_role_arn" {
  description = "Role ARN for terraform management"
  default     = "arn:aws:iam::01234567891:role/terraform_management"
}
variable "bucket_remote_state" {
  description = "S3 bucket for remote state smart-garage project infrastructure"
  default     = "smart-garage-terraform-remote-state-storage"
}

variable "bucket_region" {
  description = "S3 bucket region for remote state smart-garage infrastructure"
  default     = "us-east-2"
}

variable "workspace" { default = "smart-garage" }

variable "bucket_name" { default = "smartgarage.ca" }
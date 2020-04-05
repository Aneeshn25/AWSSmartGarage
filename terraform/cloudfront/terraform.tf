terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "smart-garage-terraform-remote-state-storage"
    dynamodb_table = "smart-garage-terraform-state-locks"
    region         = "us-east-2"
    key            = "cloudfront/terraform.tfstate"
    profile        = "smart-garage"
    role_arn       = "arn:aws:iam::01234567891:role/terraform_management"
  }
}

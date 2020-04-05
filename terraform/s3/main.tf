provider "aws" {
  region = "${var.AWS_REGION}"
  version = "~> 2.4"
}

resource "aws_s3_bucket" "website" {
  bucket = "smartgarage.ca"
  acl    = "public-read"
  policy = "${file("policy.json")}"

  website {
    index_document = "index.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}
- Install terraform binary. Download from [here](https://www.terraform.io/downloads.html)

- Replace your AWS account ID in all the var.tf files with in terraform 

create dynamodb table with smart-garage-terraform-state-locks and s3 bucket smart-garage-terraform-remote-state-storage as stated in terraform.tf 

create role terraform_management

create inline policy s3_terraform_state

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": [
                "arn:aws:s3:::smart-garage-terraform-remote-state-storage"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::smart-garage-terraform-remote-state-storage/*"
            ]
        }
    ]
}

create inline policy dynamo_terraform_state

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem"
            ],
            "Resource": "arn:aws:dynamodb:*:*:table/smart-garage-terraform-state-locks"
        }
    ]
}
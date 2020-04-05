#OUTPUT
output "website_bucket_domain_name" {
  value = "${aws_s3_bucket.website.bucket_domain_name}"
}

output "website_bucket_website_endpoint" {
  value = "${aws_s3_bucket.website.website_endpoint}"
}

output "website_bucket_arn" {
  value = "${aws_s3_bucket.website.arn}"
}

output "website_bucket_name" {
  value = "${aws_s3_bucket.website.id}"
}


output "s3_endpoint" {
  description = "URL of the website"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}



output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cf.domain_name
}

output "domain_name" {
  value = "${aws_route53_record.www.name}"
}

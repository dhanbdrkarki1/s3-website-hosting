output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cf.domain_name
}

output "root_domain" {
  value = aws_route53_record.root.name
}

output "website_link" {
  value = aws_route53_record.www.name
}

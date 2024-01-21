output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cf.domain_name
}

output "domain_name" {
  value = aws_route53_record.www.name
}

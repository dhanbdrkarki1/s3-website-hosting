// route 53
resource "aws_route53_zone" "main" {
  name = var.root_domain_name
  
}

# resource "aws_route53_record" "ns_record" {
#   allow_overwrite = true
#   name            = var.root_domain_name
#   ttl             = 172800
#   type            = "NS"
#   zone_id         = aws_route53_zone.main.zone_id
#   records         = var.name_servers
# }

# resource "aws_route53_record" "soa_record" {
#   zone_id         = aws_route53_zone.main.zone_id
#   name            = var.root_domain_name
#   type            = "SOA"
#   ttl             = 900
#   allow_overwrite = true

#   records = [
#     "${var.name_servers[0]}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
#   ]
# }



resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.root_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.root_domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}

# ACM certificate validation resource using the certificate ARN and a list of validation record FQDNs.
resource "aws_acm_certificate_validation" "cert" {
  provider = aws.acm_default_region
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# validation of an ACM certificate in collboration with other resources
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}

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


resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.root_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}



# requesting Amazon-issued certificate from ACM
resource "aws_acm_certificate" "cert" {
  provider = aws.acm_default_region
  domain_name               = var.root_domain_name
  subject_alternative_names = ["*.${var.root_domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }


}


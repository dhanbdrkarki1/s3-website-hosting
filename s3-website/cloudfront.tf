locals {
  s3_origin_id = "${var.bucket_name}-origin"
}

resource "aws_cloudfront_origin_access_control" "oac_control" {
  name                              = aws_s3_bucket_website_configuration.website.website_endpoint
  description                       = "This is a OAC Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


resource "aws_cloudfront_distribution" "cf" {
  depends_on = [aws_s3_bucket.hosting_bucket]
  origin {
    domain_name              = aws_s3_bucket.hosting_bucket.bucket_regional_domain_name
    origin_id                = local.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac_control.id

  }

  comment             = "${var.root_domain_name} distribution"
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases = [ var.root_domain_name, "*.${var.root_domain_name}" ]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id


    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  # acm certificate
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.cert.certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
    # cloudfront_default_certificate = true

  }

}
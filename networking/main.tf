# --- s3-website-ext-dns.networking.main ---

data "aws_route53_zone" "selected" {
  name = var.domain_name
}

resource "aws_acm_certificate" "cert" {
  domain_name       = data.aws_route53_zone.selected.name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Project = var.project_name
  }
}

resource "aws_route53_record" "validation" {
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
  zone_id         = data.aws_route53_zone.selected.zone_id
}

resource "aws_cloudfront_distribution" "distribution" {
  is_ipv6_enabled = true
  enabled         = true
  origin {
    domain_name = var.bucket_regional_domain_name # aws_s3_bucket_website_configuration.hosting.website_endpoint
    origin_id   = var.bucket_regional_domain_name
  }


  default_cache_behavior {
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.bucket_regional_domain_name
  }
  aliases             = [var.domain_name]
  default_root_object = var.default_root_object

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Project = var.project_name
  }
}

resource "aws_route53_record" "alias" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
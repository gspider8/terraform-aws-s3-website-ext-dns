# --- s3-website-ext-dns.networking.outputs ---

output "acm_certificate" {
  value = aws_acm_certificate.main
}

output "cloudfront_distribution" {
  value = aws_cloudfront_distribution.main
}

output "hosted_zone" {
  value = data.aws_route53_zone.main
}
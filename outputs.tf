# --- s3-website-ext-dns.outputs ---

output "bucket" {
  value = module.storage.bucket
}

output "bucket_website_configuration" {
  value = module.storage.bucket_website_configuration
}

output "acm_certificate" {
  value = module.networking.acm_certificate
}

output "cloudfront_distribution" {
  value = module.networking.cloudfront_distribution
}

output "hosted_zone" {
  value = module.networking.hosted_zone
}
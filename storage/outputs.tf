# --- s3-website-ext-dns.storage.outputs ---

output "bucket" {
  value = aws_s3_bucket.main
}

output "bucket_website_configuration" {
  value = aws_s3_bucket_website_configuration.main
}

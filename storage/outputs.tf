# --- s3-website-ext-dns.storage.outputs ---

output "main_bucket" {
  value = aws_s3_bucket.main
}

output "main_bucket_website_configuration" {
  value = aws_s3_bucket_website_configuration.hosting
}

# --- s3-website-ext-dns.variables ---

variable "domain_name" {
  description = "domain name that the s3 bucket will be hosted on in format example.com or subdomain.example.com"
  type        = string
}

variable "tags" {
  description = "tags applied to all resources"
  type        = map(string)
}

# --- s3-website-ext-dns.main ---

module "storage" {
  source      = "./storage"
  domain_name = var.domain_name
  tags        = var.tags
}

module "networking" {
  source                      = "./networking"
  domain_name                 = var.domain_name
  tags                        = var.tags
  bucket_regional_domain_name = module.storage.bucket.bucket_regional_domain_name
  default_root_object         = "index.html"
}
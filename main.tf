# --- s3-website-ext-dns.main ---

module "storage" {
  source = "./storage"
  domain_name = var.domain_name
  project_name = var.project_name
}

module "networking" {
  source = "./networking"
  domain_name = var.domain_name
  project_name = var.project_name
  bucket_regional_domain_name = module.storage.main_bucket.bucket_regional_domain_name
  default_root_object = "index.html"
}


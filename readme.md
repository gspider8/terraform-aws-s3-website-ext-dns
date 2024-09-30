# AWS S3 Bucket to host a static website

- Terraform module which creates:
  - An S3 bucket that can host a static website. 
  - A Cloudfront Distribution 
  - ACM Record for HTTPS 
  - DNS Records in Previously Created Route 53 Hosted Zone to verify ACM and connect to Cloudfront

## Usage

### Terraform 
```hcl
module "website" {
  source = "github.com/gspider8/terraform-aws-s3-website-ext-dns//s3-website-ext-dns?ref=v0.0.1"
  domain_name = "example.com"
  tags = {
    project = "example-s3-website"
  }
}
```

### Domain Name
- Own a Domain at a Registrar
- Create a Hosted Zone in your Region
- Set up Name Servers on Your Domain Registrar to point to AWS
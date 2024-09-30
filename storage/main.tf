# --- s3-website-ext-dns.storage.main ---

resource "aws_s3_bucket" "main" {
  bucket = var.domain_name

  tags = {
    Project = var.project_name
  }
  #local-exec on-destroy empty bucket script
}

resource "aws_s3_bucket_public_access_block" "main_public_access" {
  bucket                  = aws_s3_bucket.main.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false 
}

resource "aws_s3_bucket_policy" "access" {
  bucket = aws_s3_bucket.main.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicReadGetObject",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.main.id}/*"
        }
      ]
    }
  )
  depends_on = [aws_s3_bucket_public_access_block.main_public_access]
}

resource "aws_s3_bucket_website_configuration" "hosting" {
  bucket = aws_s3_bucket.main.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket" "metastore" {
  bucket = "${local.prefix}-metastore"
  acl    = "private"
  versioning {
    enabled = false
  }
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "metastore" {
  bucket                  = aws_s3_bucket.metastore.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on              = [aws_s3_bucket.metastore]
}

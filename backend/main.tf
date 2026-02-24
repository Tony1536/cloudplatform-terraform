resource "aws_s3_bucket" "state_bucket" {
   bucket = var.name_s3_state_backend
   force_destroy = false

   tags = {
     Name        = var.name_s3_state_backend
   }
  
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "enabled"
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
    bucket = aws_s3_bucket.state_bucket.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
  
}
resource "aws_s3_bucket_public_access_block" "block-public-access" {
    bucket = aws_s3_bucket.state_bucket.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  
}

resource "aws_dynamodb_table" "terraform-lock-table" {
  name           = var.name_dynamodb_lock_table
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = var.name_dynamodb_lock_table
    project = var.project_name
  }
  
}
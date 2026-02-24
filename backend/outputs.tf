output "s3_bucket_info" {
  value = {
    name   = aws_s3_bucket.name_s3_state_backend.bucket
    arn    = aws_s3_bucket.name_s3_state_backend.arn
    region = aws_s3_bucket.name_s3_state_backend.region
  }
}

output "dynamodb_table_info" {
  value = {
    name   = aws_dynamodb_table.terraform_lock_table.name
    arn    = aws_dynamodb_table.terraform_lock_table.arn
    region = aws_dynamodb_table.terraform_lock_table.region
  }
}

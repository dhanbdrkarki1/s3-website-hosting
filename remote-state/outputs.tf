output "s3_bucket_arn" {
  description = "The name of the bucket created"
  value       = aws_s3_bucket.tf_bucket.bucket
}


output "dynamodb_table_name" {
  description = "The name of the locks table"
  value       = aws_dynamodb_table.dynamodb_table.name
}
aws_region     = "us-east-1"
profile        = "dhans3"
bucket_name    = "dhan-tf-state"
dynamodb_table = "dhan-tf-state-locks"

default_tags = {
  OwnedBy     = "Dhan Bdr Karki"
  ManagedBy   = "Terraform"
  Environment = "Dev"
  Name        = "Terraform Remote State"
}

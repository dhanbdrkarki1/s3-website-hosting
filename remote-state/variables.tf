variable "profile" {
  description = "Name of the User Profile"
  type        = string
}

variable "aws_region" {
  description = "The name of region to maintain remote terraform state"
  type        = string
}

variable "bucket_name" {
  description = "Name of the bucket to keep terraform state"
  type        = string
}

variable "dynamodb_table" {
  description = "The name of the dynamodb table to lock state"
  type        = string
}

variable "default_tags" {
  description = "Custom tags to set on all the components."
  type        = map(string)

}

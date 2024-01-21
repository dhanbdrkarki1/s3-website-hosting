variable "profile" {
  description = "The name of the User Profile"
  type        = string
}

variable "aws_region" {
  description = "The region to deploy static website"
  type        = string
}

variable "bucket_name" {
  description = "The name of the website bucket"
  type        = string
}

variable "folder_to_upload" {
  description = "The name of the folder to upload"
  type        = string
}


variable "root_domain_name" {
  description = "Name of the root domain"
  type        = string
}


variable "default_tags" {
  description = "Custom tags to set on all the components."
  type        = map(string)
  default     = {}
}

# variable "name_servers" {
#     type    = tuple([string, string, string, string])
#   description = "The list of nameservers of registered domain name"
# }
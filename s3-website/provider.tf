terraform {
  required_version = "~> 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    key = "dev/terraform.tfstate"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.profile

  default_tags {
    tags = var.default_tags
  }
}

# SSL certificates must be set up in the North Virginia (us-east-1) region for CloudFront.
provider "aws" {
  alias = "acm_default_region"
  region = "us-east-1"
  profile = var.profile
}
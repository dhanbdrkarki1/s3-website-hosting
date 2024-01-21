resource "aws_s3_bucket" "hosting_bucket" {
  bucket        = var.bucket_name
  force_destroy = true // Solution to 'Bucket is not empty' error when destroying
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket_owner" {
  bucket = aws_s3_bucket.hosting_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.hosting_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_owner,
    aws_s3_bucket_public_access_block.block_public_access,
  ]

  bucket = aws_s3_bucket.hosting_bucket.id
  acl    = "private"
}



data "aws_iam_policy_document" "s3_bucket_policy" {
  depends_on = [
    aws_s3_bucket.hosting_bucket,
    aws_cloudfront_distribution.cf
  ]

  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [aws_s3_bucket.hosting_bucket.arn, "${aws_s3_bucket.hosting_bucket.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.cf.arn]
    }
  }

}

resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
  depends_on = [data.aws_iam_policy_document.s3_bucket_policy]
  bucket     = aws_s3_bucket.hosting_bucket.id
  policy     = data.aws_iam_policy_document.s3_bucket_policy.json

}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.hosting_bucket.id

  index_document {
    suffix = "index.html"
  }
}

module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "${path.module}/${var.folder_to_upload}"
}


// upload all files from web folder to the s3 bucket
resource "aws_s3_object" "hosting_bucket_files" {
  bucket = aws_s3_bucket.hosting_bucket.id

  for_each = module.template_files.files

  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  content = each.value.content

  etag = each.value.digests.md5
}



variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for static website hosting"
  type        = string
  default     = "test.vishalupadhyay.me"
}

variable "website_configuration" {
  description = "Configuration for S3 bucket website hosting"
  type = object({
    index_document = string
    error_document = string
  })
  default = {
    index_document = "index.html"
    error_document = "error.html"
  }
}

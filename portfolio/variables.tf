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

variable "acm_certificate_arn" {
  description = "The ARN of the ACM SSL certificate (must be in us-east-1 for CloudFront)"
  type        = string
  default     = "arn:aws:acm:us-east-1:626677316159:certificate/a55f9f57-1f1a-463c-b389-b5a1a68207e3"
}


# aws acm describe-certificate --certificate-arn arn:aws:acm:us-east-1:626677316159:certificate/a55f9f57-1f1a-463c-b389-b5a1a68207e3 --region us-east-1

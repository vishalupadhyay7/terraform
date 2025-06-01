provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "static_website" {
  bucket = var.s3_bucket_name

  tags = {
    Name = var.s3_bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "static_website_public_access_block" {
  bucket                  = aws_s3_bucket.static_website.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# resource "aws_s3_bucket_acl" "static_website_acl" {
#   bucket = aws_s3_bucket.static_website.id
#   acl    = "public-read"
# }

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = var.website_configuration.index_document
  }

  error_document {
    key = var.website_configuration.error_document
  }
}

resource "aws_s3_bucket_policy" "static_website_policy" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
      }
    ]
  })
}

# resource "aws_cloudfront_distribution" "static_website" {
#   origin {
#     domain_name = aws_s3_bucket.static_website.website_endpoint
#     origin_id   = "S3-static-website"
#   }

#   enabled = true

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "S3-static-website"

#     viewer_protocol_policy = "redirect-to-https"

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   tags = {
#     Name = "Static Website CloudFront"
#   }
# }

# resource "aws_route53_zone" "static_website_zone" {
#   name = "example.com" # Replace with your domain name
# }

# resource "aws_route53_record" "static_website_record" {
#   zone_id = aws_route53_zone.static_website_zone.zone_id
#   name    = "www.example.com" # Replace with your subdomain
#   type    = "A"

#   alias {
#     name                   = aws_cloudfront_distribution.static_website.domain_name
#     zone_id                = aws_cloudfront_distribution.static_website.hosted_zone_id
#     evaluate_target_health = false
#   }
# }

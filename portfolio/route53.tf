
data "aws_route53_zone" "portfolio_zone" {
  name         = "vishalupadhyay.me"
  private_zone = false
}

resource "aws_route53_record" "portfolio_record" {
  zone_id = data.aws_route53_zone.portfolio_zone.zone_id
  name    = "test.vishalupadhyay.me"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.portfolio.domain_name
    zone_id                = aws_cloudfront_distribution.portfolio.hosted_zone_id
    evaluate_target_health = false
  }
}

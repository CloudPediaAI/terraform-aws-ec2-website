# (Recommended for EC2) Policy for origins that return Cache-Control headers. Query strings are not included in the cache key.
data "aws_cloudfront_cache_policy" "cache_control_headers" {
  name = "UseOriginCacheControlHeaders"
}

# (Recommended for EC2) Policy to forward all parameters in viewer requests
data "aws_cloudfront_origin_request_policy" "managed_all_viewer" {
  name = "Managed-AllViewer"
}

resource "aws_cloudfront_distribution" "public" {
  origin {
    domain_name = var.ec2_public_ipv4_dns
    origin_id   = "EC2-${var.domain_name}"
    custom_origin_config {
      http_port              = var.ec2_http_port
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront for Website ${var.domain_name} hosted on EC2"
  default_root_object = var.default_root_object

  aliases = local.domain_aliases

  default_cache_behavior {
    cache_policy_id          = data.aws_cloudfront_cache_policy.cache_control_headers.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.managed_all_viewer.id

    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "EC2-${var.domain_name}"

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.root.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = var.tags
}

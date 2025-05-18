output "cloudfront" {
  value       = aws_cloudfront_distribution.public
  description = "CloudFront created for the EC2 Website"
}

output "website_url" {
  value       = local.domain_urls
  description = "URL of the EC2 Website"
}

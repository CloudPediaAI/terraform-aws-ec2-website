output "cloudfront" {
  value       = aws_cloudfront_distribution.public
  description = "CloudFront created for the EC2 Website"
}

output "website_url" {
  value       = "https://${local.domain_name}"
  description = "URL of the EC2 Website"
}

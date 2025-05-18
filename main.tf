terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.36.0"
      configuration_aliases = [aws.us-east-1, aws]
    }
  }
}

locals {
  domain_name     = lower(var.domain_name)
  www_domain_name = "www.${local.domain_name}"
  domain_aliases  = (var.need_www_subdomain) ? [local.domain_name, local.www_domain_name] : [local.domain_name]
  domain_urls     = (var.need_www_subdomain) ? ["https://${local.domain_name}", "https://${local.www_domain_name}"] : ["https://${local.domain_name}"]
}

data "aws_caller_identity" "current" {}


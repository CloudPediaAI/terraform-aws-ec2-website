variable "domain_name" {
  type        = string
  description = "Domain for the Website eg. mywebsite.com"
  validation {
    condition = (can(regex("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])\\.)*([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9])$", var.domain_name))
      && !strcontains(var.domain_name, "..")
      && !startswith(var.domain_name, "xn--")
      && !startswith(var.domain_name, "sthree-")
      && !endswith(var.domain_name, "-s3alias")
    && !endswith(var.domain_name, "--ol-s3"))
    error_message = "Provide a valid domain name. Since S3 bucket will be created with the same name, all bucket naming rules are applicable here.  Please refer https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html"
  }
}

variable "hosted_zone_id" {
  type        = string
  default = null
  description = "Id of the Hosted Zone in Route 53"
}

variable "need_www_subdomain" {
  type        = bool
  default     = false
  description = "Whether the wwww subdomain required or not. If yes, this module will add 2 records in Route 53 with domain_name.com and www.domain_name.com"
}

variable "ec2_public_ipv4_dns" {
  type = string
  default = null
  description = "Public IPv4 DNS of EC2 instance"
}

variable "ec2_http_port" {
  type = number
  default = 80
  description = "HTTP Port where the website is configured in EC2"
}

variable "default_root_object" {
  type        = string
  default     = "index.html"
  description = "Default root object for the website"
}

variable "tags" {
  type = map(any)
  description = "Key/Value pairs for the tags"
  default = {
    created_by = "Terraform Module cloudpediaai/static-website/aws"
  }
}

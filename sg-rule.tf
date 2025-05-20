data "aws_ec2_managed_prefix_list" "cloudfront" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

resource "aws_security_group_rule" "allow_cloudfront" {
  count = (var.ec2_security_group_id != null) ? 1 : 0

  type              = "ingress"
  from_port         = var.ec2_http_port
  to_port           = var.ec2_http_port
  protocol          = "tcp"
  security_group_id = var.ec2_security_group_id
  prefix_list_ids   = [data.aws_ec2_managed_prefix_list.cloudfront.id]
  description       = "Allow CloudFront to access EC2 on port ${var.ec2_http_port}"
}

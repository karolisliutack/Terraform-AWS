# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name = "private-sg"
  description = "Security Group with HTTP & SSH port open for entire VPC Block (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}

#https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/v4.17.1/examples/complete/main.tf
#https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest?tab=inputs
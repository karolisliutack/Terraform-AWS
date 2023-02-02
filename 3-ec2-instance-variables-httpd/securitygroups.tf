# Create Security Group - SSH Traffic
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "vpc-ssh" { #aws_security_group - resource type, resource local name - vpc-ssh
  name        = "vpc-ssh"
  description = "Dev VPC SSH"
  ingress { #inbound rule
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #internet edge traffic 0.0.0.0/0
  }

  egress { #outbound rule
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #internet edge traffic 0.0.0.0/0
  }

  tags = {
    Name = "vpc-ssh"
  }
}

# Create Security Group - Web Traffic
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "vpc-web" {
  name        = "vpc-web"
  description = "Dev VPC Web"
  ingress {
    description = "Allow Port 80" #web traffic 80
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Port 443" #Additional traffic rule for security group
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-web"
  }
}

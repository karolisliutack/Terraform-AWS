data "aws_ami" "amzlinux2" { 
  most_recent = true       #most recent AMI if there are multiple ami available
  owners      = ["amazon"] #amazon owners
  filter {
    name   = "name"
    #values = ["amzn2-ami-hvm-*-gp2"]
    values =  ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]	
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
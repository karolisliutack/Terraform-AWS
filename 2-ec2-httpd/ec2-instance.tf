# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami           = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  user_data     = file("${path.module}/httpd-install.sh") #file function allows to read content from respective file
  tags = {
    "Name" = "EC2 Demo"
  }
}

#http://54.158.223.107/app1/index.html - Public IP, create HHTP rule for security group from anywhere
#http://54.158.223.107/app1/metadata.html

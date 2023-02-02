# EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  #instance_type = var.instance_type_list[1] #for List to reference t3-small
  #instance_type = var.instance_type_map["dev"] #for MAP to reference t3-micro
  user_data = file("${path.module}/httpd-install.sh") #file function allows to read content from respective file
  key_name = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id   ]
  #https://developer.hashicorp.com/terraform/language/meta-arguments/count
  count = 2
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }
}
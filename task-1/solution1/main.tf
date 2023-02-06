
# EC2 Instance
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "myec2vm" {
  ami                    = data.aws_ami.ubuntu.id 
  instance_type          = var.instance_type
  #user_data              = file("${path.module}/httpd-install.sh") #file function allows to read content from respective file
  key_name               = var.instance_keypair
  associate_public_ip_address = true 
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]


  provisioner "remote-exec" {
    inline = [
          "echo 'Wait until ssh connected'"
    ]

    connection {
      type     = "ssh"
      host     = aws_instance.myec2vm.public_ip
      user     = "ubuntu"
      private_key = file("private-key/terraform-key.pem")
    }  
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i ${aws_instance.myec2vm.public_ip}, --private-key ${var.private_key_path} -e 'pub_key=${var.private_key_path}' nginx.yaml"
  }



  tags = {
    "Name" = "EC2 Demo 2"
  } 
  
}

  


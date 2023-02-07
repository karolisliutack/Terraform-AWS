provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myec2vm" {
  count = 2
  ami   = data.aws_ami.ubuntu.id 
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  key_name               = var.instance_keypair

    provisioner "remote-exec" {
    inline = [
          "echo 'Wait until ssh connected'"
    ]

    connection {
      type     = "ssh"
      host     = self.public_ip
      user     = "ubuntu"
      private_key = file("private-key/terraform-key.pem")
    }  
}

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i ${self.public_ip}, --private-key ${var.private_key_path} -e 'pub_key=${var.private_key_path}' nginx.yaml"
  }

}
# Create a new load balancer
resource "aws_elb" "bar" {
  name               = "foobar-terraform-elb"
  availability_zones = ["us-east-1d"]


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

        instances                   = [
        aws_instance.myec2vm[0].id,     
        aws_instance.myec2vm[1].id
    ]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elb"
  }
}
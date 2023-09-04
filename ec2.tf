

resource "aws_instance" "web" {
  ami           = "ami-03a3f9256a6f5bdb4"
  instance_type = "t2.micro"
  key_name = "web-ec2-keypair"
  subnet_id = web_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "web-server"
  }

  provisioner "file" {
    source = "./web-ec2-keypair.pem"
    destination = "/home/ec2-user/web-ec2-keypair.pem"
  
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("./web-ec2-keypair.pem")}"
    }  
  }
}

resource "aws_instance" "db" {
  ami           = "ami-08df646e18b182346"
  instance_type = "t2.micro"
  key_name = "web-ec2-keypair"
  subnet_id = app_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "app Server"
  }
}

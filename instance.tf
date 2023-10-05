resource "aws_instance" "bastion" {
  ami                         = "ami-06e46074ae430fba6"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_az1.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh_from_anywhere.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.tf-key-pair.key_name
  user_data                   = <<-EOF
              #!/bin/bash
              echo '${tls_private_key.rsa.private_key_pem}' > ~/tf.pem
              chmod 0400 ~/tf.pem
              EOF
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > bastion_host_ip"
  }
  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_instance" "application" {
  ami                    = "ami-06e46074ae430fba6"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_az1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_and_3000_from_vpc.id]
  key_name               = aws_key_pair.tf-key-pair.key_name
  tags = {
    Name = "Application Server"
  }
}
# # Compute
resource "aws_security_group" "allow_ssh_from_anywhere" {
  name        = "allow_ssh_from_anywhere"
  description = "Security group allowing SSH from anywhere"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.lab_vpc.id
}

resource "aws_security_group" "allow_ssh_and_3000_from_vpc" {
  name        = "allow_ssh_and_3000_from_vpc"
  description = "Security group allowing SSH and port 3000 from VPC CIDR only"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.lab_vpc.cidr_block]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.lab_vpc.cidr_block]
  }
  vpc_id = aws_vpc.lab_vpc.id
}

resource "aws_instance" "bastion" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_az1.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh_from_anywhere.id]
  associate_public_ip_address = true
  key_name                    = "Ansii"
  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_instance" "application" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_az1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_and_3000_from_vpc.id]
  key_name               = "Ansii"
  tags = {
    Name = "Application Server"
  }
}
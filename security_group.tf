resource "aws_security_group" "allow_ssh_from_anywhere" {
  name        = "allow_ssh_from_anywhere"
  description = "Security group allowing SSH from anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.lab_vpc.id
}

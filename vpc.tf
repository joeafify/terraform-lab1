resource "aws_vpc" "lab_vpc" {
  tags = {
    name : "my_terraform_vpc"
  }
  cidr_block = var.vpc.cidr_block
}

resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id
}
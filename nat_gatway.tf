resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet_az1.id
}

resource "aws_eip" "my_eip" {
  tags = {
    Name = "elastic_ip"
  }
}
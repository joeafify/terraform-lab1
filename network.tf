
# Networking
resource "aws_vpc" "lab_vpc" {
  tags = {
    name : "my_terraform_vpc"
  }
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id
}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_az1" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_subnet_az2" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.lab_vpc.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.lab_vpc.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab_igw.id
}

# resource "aws_route" "private_route" {
#   route_table_id         = aws_route_table.private_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.my_nat_gateway.id
# }

resource "aws_route_table_association" "public_subnet_association_az1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_association_az2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association_az1" {
  subnet_id      = aws_subnet.private_subnet_az1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_association_az2" {
  subnet_id      = aws_subnet.private_subnet_az2.id
  route_table_id = aws_route_table.private_route_table.id
}

# resource "aws_nat_gateway" "my_nat_gateway" {
#   allocation_id = aws_eip.my_eip.id
#   subnet_id     = aws_subnet.public_subnet_az1.id
# }

# resource "aws_nat_gateway" "my_nat_gateway" {
#   allocation_id = aws_eip.my_eip.id
#   subnet_id     = aws_subnet.public_subnet_az1.id
# }


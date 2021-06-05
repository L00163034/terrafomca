resource "aws_vpc" "main" {
  #in the assignment don't forget to change the network numbers!
  cidr_block = var.IP_address_space

  #tags = var.tags
}

resource "aws_subnet" "pub_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.Pub_Subnet
  availability_zone       = var.Availability_Zone
  map_public_ip_on_launch = true

  #tags = var.tags
}

resource "aws_subnet" "prv_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.Prv_Subnet
  availability_zone       = var.Availability_Zone
  map_public_ip_on_launch = false

  #tags = var.tags
}

resource "aws_subnet" "DB_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.DB_Subnet
  availability_zone       = var.Availability_ZoneB
  map_public_ip_on_launch = false

  #tags = var.tags
}

resource "aws_internet_gateway" "inet_gateway" {
  vpc_id = aws_vpc.main.id

  #tags = var.tags
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_elastic_ip.id
  subnet_id     = aws_subnet.pub_subnet.id

  #tags = var.tags
}

resource "aws_eip" "nat_elastic_ip" {
  vpc = true
  #tags = var.tags
}
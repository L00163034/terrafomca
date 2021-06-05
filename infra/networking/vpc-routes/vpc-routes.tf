resource "aws_route_table" "public_routing_table" {
  vpc_id = var.vpc_id

  route { #traffic from anywhere is routed
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  #tags = var.tags
}

# private routing table
resource "aws_route_table" "private_routing_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  #tags = var.tags
}

resource "aws_route_table_association" "rt_assoc" {
  subnet_id      = var.pub_subnet_id
  route_table_id = aws_route_table.public_routing_table.id
}

resource "aws_route_table_association" "private_routing_table_assoc" {
  subnet_id      = var.prv_subnet_id
  route_table_id = aws_route_table.private_routing_table.id
}

resource "aws_route_table_association" "RDS_routing_table_assoc" {
  subnet_id      = var.db_subnet_id
  route_table_id = aws_route_table.private_routing_table.id
}
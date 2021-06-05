output "vpc_id" {
  value = aws_vpc.main.id
}
output "gateway_id" {
  value = aws_internet_gateway.inet_gateway.id
}
output "pub_subnet_id" {
  value = aws_subnet.pub_subnet.id
}
output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.id
}
output "prv_subnet_id" {
  value = aws_subnet.prv_subnet.id
}
output "db_subnet_id" {
  value = aws_subnet.DB_subnet.id
}
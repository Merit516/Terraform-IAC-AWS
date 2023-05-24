output "public_subnet_ids"{
    value = aws_subnet.public_subnets[*].id
}
output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gw.id
}
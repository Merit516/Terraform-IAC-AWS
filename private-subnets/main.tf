resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags ={
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "private_routs" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id=var.nat_gateway_ids
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.private_subnet_cidrs)

  subnet_id      = aws_subnet.private_subnets[0].id
  route_table_id = aws_route_table.private_routs.id
}
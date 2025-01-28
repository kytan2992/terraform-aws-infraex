resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${ local.resource_prefix }-public-route-table"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${ local.resource_prefix }-private-route-table"
  }
}

resource "aws_route_table" "db_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${ local.resource_prefix }-db-route-table"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route" "private_access" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "subnet_a_assoc" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "subnet_b_assoc" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "subnet_c_assoc" {
  subnet_id      = aws_subnet.subnet_c.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "subnet_d_assoc" {
  subnet_id      = aws_subnet.subnet_d.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "subnet_e_assoc" {
  subnet_id      = aws_subnet.subnet_e.id
  route_table_id = aws_route_table.db_rt.id
}

resource "aws_route_table_association" "subnet_f_assoc" {
  subnet_id      = aws_subnet.subnet_f.id
  route_table_id = aws_route_table.db_rt.id
}
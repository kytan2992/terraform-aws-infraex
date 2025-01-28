resource "aws_security_group" "terra-sg" {
  name        = "${ local.resource_prefix }-terra-SG"
  description = "Security Group created from terraform"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "allowhttp" {
  security_group_id = aws_security_group.terra-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allowssh" {
  security_group_id = aws_security_group.terra-sg.id

  cidr_ipv4         = "0.0.0.0/0"  
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allowping" {
  security_group_id = aws_security_group.terra-sg.id

  cidr_ipv4         = "0.0.0.0/0"  
  from_port         = -1
  ip_protocol       = "icmp"
  to_port           = -1
}


resource "aws_vpc_security_group_egress_rule" "outgoing" {
  security_group_id = aws_security_group.terra-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = "-1"
  to_port     = -1
}
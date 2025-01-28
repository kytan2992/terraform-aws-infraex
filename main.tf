locals {
 resource_prefix = "ky-tf"
}

resource "aws_vpc" "main" {
  cidr_block       = var.base_cidr_block
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${ local.resource_prefix }-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${ local.resource_prefix }-igw"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.base_cidr_block, 8, 1)
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${ local.resource_prefix }-public-subnet-1a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.base_cidr_block, 8, 2)
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${ local.resource_prefix }-public-subnet-1b"
  }
}

resource "aws_subnet" "subnet_c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.base_cidr_block, 8, 3)
  availability_zone = "us-east-1a"

  tags = {
    Name = "${ local.resource_prefix }-private-subnet-1a"
  }
}

resource "aws_subnet" "subnet_d" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.base_cidr_block, 8, 4)
  availability_zone = "us-east-1b"

  tags = {
    Name = "${ local.resource_prefix }-private-subnet-1b"
  }
}

resource "aws_subnet" "subnet_e" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.base_cidr_block, 8, 5)
  availability_zone = "us-east-1a"

  tags = {
    Name = "${ local.resource_prefix }-db-subnet-1a"
  }
}

resource "aws_subnet" "subnet_f" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.base_cidr_block, 8, 6)
  availability_zone = "us-east-1b"

  tags = {
    Name = "${ local.resource_prefix }-db-subnet-1b"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${ local.resource_prefix }-eip-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_a.id

  tags = {
    Name = "${ local.resource_prefix }-nat-igw"
  }
}




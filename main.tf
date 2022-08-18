#_________________________________
#          VPC
#---------------------------------
resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }
}

#_________________________________
#          IGW
#---------------------------------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = "${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }
}

#_________________________________
#          Public Subnets
#---------------------------------

resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr,3,0)
  availability_zone = data.aws_availability_zones.AZs.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name    = "Public-1-${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }
}

resource "aws_subnet" "public-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr,3,1)
  availability_zone = data.aws_availability_zones.AZs.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name    = "Public-2-${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }
}

resource "aws_subnet" "public-3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr,3,2)
  availability_zone = data.aws_availability_zones.AZs.names[2]
  map_public_ip_on_launch = true

  tags = {
    Name    = "Public-3-${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }
}

#_________________________________
#          Private Subnets
#---------------------------------

resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr,3,3)
  availability_zone = data.aws_availability_zones.AZs.names[0]

  tags = {
    Name    = "Private-1-${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }
}

resource "aws_subnet" "private-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr,3,4)
  availability_zone = data.aws_availability_zones.AZs.names[1]

  tags = {
    Name    = "Private-2-${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }
}

resource "aws_subnet" "private-3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr,3,5)
  availability_zone = data.aws_availability_zones.AZs.names[2]

  tags = {
    Name    = "Private-3-${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }
}

#__________________________________
#           EIP
#----------------------------------

resource "aws_eip" "ngw" {
  vpc      = true
  tags = {
    Name    = "EIP-${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }
}

#__________________________________
#            NGW
#----------------------------------

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.public-2.id

  tags = {
    Name    = "${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }
}

#__________________________________
#          Public-RTB
#----------------------------------

resource "aws_route_table" "Public-RTB" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name    = "Public-RTB-${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }

}

#__________________________________
#          Private-RTB
#----------------------------------

resource "aws_route_table" "Private-RTB" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name    = "Private-RTB-${var.project}-${var.env}"
    Project = var.project
    Env     = var.env
  }

}

#_____________________________________________
#          Public-RTB-Association
#---------------------------------------------

resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.Public-RTB.id
}

resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.Public-RTB.id
}

resource "aws_route_table_association" "public-3" {
  subnet_id      = aws_subnet.public-3.id
  route_table_id = aws_route_table.Public-RTB.id
}

#________________________________________________
#          Private-RTB-Association
#------------------------------------------------

resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.Private-RTB.id
}

resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.Private-RTB.id
}

resource "aws_route_table_association" "private-3" {
  subnet_id      = aws_subnet.private-3.id
  route_table_id = aws_route_table.Private-RTB.id
}

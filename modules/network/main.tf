###########
#vpc
###########
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "main_vpc"
  }
}

###########
#internet gateway
###########
resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "int_gateway"
  }
}

##########
#public subnet
########## 
resource "aws_subnet" "public_sub" {
  count = length(var.pub_sub)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone = element(var.AZs,count.index)  

  tags = {
    Name = var.pub_sub[count.index]
  }
}

############
#route table
############
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
    tags = {
    Name = "public-route-table"
  }
}

# Route table associte
resource "aws_main_route_table_association" "a" {
  #subnet_id      = aws_subnet.public_sub[count.index].id
  vpc_id = aws_vpc.vpc.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "lb" {
  domain = "vpc"
}


# NAT Gateway
resource "aws_nat_gateway" "main" {
  #count = length(var.pub_sub)
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public_sub[0].id

  tags = {
    Name = "main-nat-gateway"
  }
}

# Private Subnet 
resource "aws_subnet" "private" {
  count = length(var.priv_sub) 
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.priv_cidrs[count.index]
  availability_zone = element(var.AZs,count.index)

  tags = {
    Name = var.priv_sub[count.index]
  }
}

# Route Table for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# Associate Route Table with Private Subnet
resource "aws_route_table_association" "private" {
  count = length(var.priv_sub)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

############
#secrity group
############

resource "aws_security_group" "nginx_sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Apache
resource "aws_security_group" "apache_sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.nginx_sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

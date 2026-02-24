resource "aws_vpc" "cloudplatform_vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.vpc_tag_name
  }
}

# public subnets

resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.cloudplatform_vpc.id
  cidr_block              = var.public_subnet_1a_cidr
  availability_zone       = var.public_subnet_1a_az
  map_public_ip_on_launch = true

  tags = {
    Name     = var.public_subnet_1a_name
    private  = "false"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.cloudplatform_vpc.id
  cidr_block              = var.public_subnet_1b_cidr
  availability_zone       = var.public_subnet_1b_az
  map_public_ip_on_launch = true

  tags = {
    Name     = var.public_subnet_1b_name
    private  = "false"
  }
}

# private subnets

resource "aws_subnet" "private_subnet_1a" {
  vpc_id                 = aws_vpc.cloudplatform_vpc.id
  cidr_block             = var.private_subnet_1a_cidr
  availability_zone      = var.private_subnet_1a_az
  map_public_ip_on_launch = false  

  tags = {
    Name      = var.private_subnet_1a_name
    private   = "true"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id                 = aws_vpc.cloudplatform_vpc.id
  cidr_block             = var.private_subnet_1b_cidr
  availability_zone      = var.private_subnet_1b_az
  map_public_ip_on_launch = false  

  tags = {
    Name      = var.private_subnet_1b_name
    private   = "true"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.cloudplatform_vpc.id

  tags = {
    Name = var.igw_name
  }
}
# public route table

resource "aws_route_table" "public_route_table_1a" {
  vpc_id = aws_vpc.cloudplatform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = var.public_route_table_name_1a
  }
}
resource "aws_route_table" "public_route_table_1b" {
  vpc_id = aws_vpc.cloudplatform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = var.public_route_table_name_1b
  }
}

# associate public subnets with route table
resource "aws_route_table_association" "associate_public_rt_1a" {
    route_table_id = aws_route_table.public_route_table_1a.id
    subnet_id      = aws_subnet.public_subnet_1a.id
  
}
resource "aws_route_table_association" "associate_public_rt_1b" {
    route_table_id = aws_route_table.public_route_table_1b.id
    subnet_id      = aws_subnet.public_subnet_1b.id
  
}
  
# nat gateway
resource "aws_nat_gateway" "nat_gateway_1a" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet_1a.id
  allocation_id     = aws_eip.nat_eip_1a.id

  depends_on = [ aws_internet_gateway.IGW ]

  tags = {
    Name = "${var.vpc_tag_name}-nat-gateway-1a"
  }
}

resource "aws_nat_gateway" "nat_gateway_1b" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet_1b.id
  allocation_id     = aws_eip.nat_eip_1b.id
  depends_on = [ aws_internet_gateway.IGW ]

  tags = {
    Name = "${var.vpc_tag_name}-nat-gateway-1b"
  }
}
# elastic IP for NAT gateway
resource "aws_eip" "nat_eip_1a" {
  domain = "vpc"

  tags = {
    Name = "${var.vpc_tag_name}-nat-eip-1a"
  }
}

resource "aws_eip" "nat_eip_1b" {
  domain = "vpc"

  tags = {
    Name = "${var.vpc_tag_name}-nat-eip-1b"
  }
}

# private route table
resource "aws_route_table" "private_route_table_1a" {
  vpc_id = aws_vpc.cloudplatform_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1a.id
  }

  tags = {
    Name = var.private_route_table_name_1a
  }
}

resource "aws_route_table" "private_route_table_1b" {
  vpc_id = aws_vpc.cloudplatform_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1b.id
  }

  tags = {
    Name = var.private_route_table_name_1b
  }
}

# associate private subnets with route tables
resource "aws_route_table_association" "private_route_table_association_1a" {
    route_table_id = aws_route_table.private_route_table_1a.id
    subnet_id      = aws_subnet.private_subnet_1a.id
}    
resource "aws_route_table_association" "private_route_table_association_1b" {
    route_table_id = aws_route_table.private_route_table_1b.id
    subnet_id      = aws_subnet.private_subnet_1b.id
}    


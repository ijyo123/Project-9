#Create VPC
resource "aws_vpc" "project9VPC" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = "default"

  tags = {
    Name = "project9VPC"
  }
}
#Create Public Subnet1
resource "aws_subnet" "p9-pubsub1" {
  vpc_id     = aws_vpc.project9VPC.id
  cidr_block = var.publicsub1-cidr
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "p9-pubsub1"
  }
}


#Create Public Subnet2
resource "aws_subnet" "p9-pubsub2" {
  vpc_id     = aws_vpc.project9VPC.id
  cidr_block = var.publicsub2-cidr
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch= true

  tags = {
    Name = "p9-pubsub2"
  }
}

#Create Private Subnets
resource "aws_subnet" "p9-privsub1" {
  vpc_id     = aws_vpc.project9VPC.id
  cidr_block = var.privatesub1-cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "p9-privsub1"
  }
}

resource "aws_subnet" "p9-privsub2" {
  vpc_id     = aws_vpc.project9VPC.id
  cidr_block = var.privatesub2-cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "p9-privsub2"
  }
}


#Create Route Table for Public Routes
resource "aws_route_table" "p9-publicroutetable" {
  vpc_id = aws_vpc.project9VPC.id

  tags = {
    Name = "p9-publicroutetable"
  }
}

#Create Route Table for Private Routes
resource "aws_route_table" "p9-privateroutetable" {
  vpc_id = aws_vpc.project9VPC.id

  tags = {
    Name = "p9-privateroutetable"
  }
}

#Create RTA for Public Subnet1
resource "aws_route_table_association" "publicp9-rta1" {
  subnet_id      = aws_subnet.p9-pubsub1.id
  route_table_id = aws_route_table.p9-publicroutetable.id
}

#Create RTA for Public Subnet2
resource "aws_route_table_association" "publicp8-rta2" {
  subnet_id      = aws_subnet.p9-pubsub2.id
  route_table_id = aws_route_table.p9-publicroutetable.id
}

#Create RTA for Private Subnet1
resource "aws_route_table_association" "privatep9-rta1" {
  subnet_id      = aws_subnet.p9-privsub1.id
  route_table_id = aws_route_table.p9-privateroutetable.id
}

#Create RTA for Private Subnet2
resource "aws_route_table_association" "privatep9-rta2" {
  subnet_id      = aws_subnet.p9-privsub2.id
  route_table_id = aws_route_table.p9-privateroutetable.id
}
#Create IGW
resource "aws_internet_gateway" "Project9-igw" {
  vpc_id = aws_vpc.project9VPC.id

  tags = {
    Name = "Project9-igw"
  }
}

#Create Route for IGW
resource "aws_route" "publicp8-igw-route" {
  route_table_id            = aws_route_table.p9-publicroutetable.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                =aws_internet_gateway.Project9-igw.id
  }


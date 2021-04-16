resource "aws_subnet" "subnet-1" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.1.0/24"
  #specify aws availability zone
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_route_table_association" "prod_route" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = var.route_id
}

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50", "10.0.1.51"]
  security_groups = [var.sec_group_id]

  
}

resource "aws_eip" "one" {
  vpc                       = true
  #network_interface         = aws_network_interface.web-server-nic.id
  #associate_with_private_ip = "10.0.1.50"
  depends_on = [
    var.internet_gate
  ]
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.one.id
  subnet_id = aws_subnet.subnet-1.id 

  tags = {
    Name ="gw NAT"
  }
  
}

resource "aws_route_table" "NAT_gateway_RT" {
  depends_on = [
    aws_nat_gateway.gw
  ]

  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
  }  
  tags = {
    Name = "Route table for Gateway"
  }
}
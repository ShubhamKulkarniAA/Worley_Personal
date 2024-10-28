resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet1_cidr
  availability_zone = var.availability_zone1
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-PublicSubnet1"
    }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet2_cidr
  availability_zone = var.availability_zone2
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-PublicSubnet2"
     }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet1_cidr
  availability_zone = var.availability_zone1

  tags = {
    Name = "${var.vpc_name}-PrivateSubnet1"
   }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet2_cidr
  availability_zone = var.availability_zone2

  tags = {
    Name = "${var.vpc_name}-PrivateSubnet2"
     }
}

resource "aws_subnet" "rds_private_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_rds_subnet1_cidr
  availability_zone = var.availability_zone1
  tags = {
    Name = "${var.vpc_name}-RDS-PrivateSubnet1"
  }
}

resource "aws_subnet" "rds_private_subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_rds_subnet2_cidr
  availability_zone = var.availability_zone2
  tags = {
    Name = "${var.vpc_name}-RDS-PrivateSubnet2"
  }
}

# Security Group for EKS Node Group

resource "aws_security_group" "eks_node_group_sg" {
  name   = "${var.vpc_name}-node-group-sg"
  vpc_id = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-node-group-sg"
  }
}

# Ingress Rule to allow traffic from the control plane

resource "aws_security_group_rule" "allow_eks_control_plane" {
  type                     = "ingress"
  from_port               = 443
  to_port                 = 443
  protocol                = "tcp"
  security_group_id      = aws_security_group.eks_node_group_sg.id
  source_security_group_id = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-PublicRouteTable"
  }
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_subnet1_route_table_association" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_route_table_association" {
  subnet_id = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-PrivateRouteTable"
  }
}

resource "aws_route_table_association" "private_subnet1_route_table_association" {
  subnet_id = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet2_route_table_association" {
  subnet_id = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}

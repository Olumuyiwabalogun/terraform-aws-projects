terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

locals {
  common_tags = {
    Name        = var.name
    Environment = var.environment
    Project     = "Neos-Terraform"
    ManagedBy   = "Terraform"
  }
}
resource "aws_vpc" "neosvpc" {
    cidr_block = var.myvpc
    tags = local.common_tags
    
}
resource "aws_subnet" "neossubnet" {
    vpc_id = aws_vpc.neosvpc.id
    cidr_block = var.subnet_cidr
    tags = local.common_tags
    
}

resource "aws_internet_gateway" "neosigw" {
    vpc_id = aws_vpc.neosvpc.id
    tags = local.common_tags
}
resource "aws_route_table" "neosroutetable" {
    vpc_id = aws_vpc.neosvpc.id
    tags = local.common_tags
}

resource "aws_route" "neosroute" {
    route_table_id = aws_route_table.neosroutetable.id
    destination_cidr_block = var.route_dst_cidr_block
    gateway_id = aws_internet_gateway.neosigw.id
}
resource "aws_route_table_association" "neosroutetableassociation" {
    subnet_id = aws_subnet.neossubnet.id
    route_table_id = aws_route_table.neosroutetable.id
}
resource "aws_security_group" "neossg" {
    name = var.name
    vpc_id = aws_vpc.neosvpc.id
    tags = local.common_tags
}
resource "aws_security_group_rule" "neossgrule" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.route_dst_cidr_block]
    security_group_id = aws_security_group.neossg.id
}
resource "aws_security_group_rule" "neossgrule2" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.route_dst_cidr_block]
    security_group_id = aws_security_group.neossg.id
}

resource "aws_security_group_rule" "neossgrule3" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.route_dst_cidr_block]
    security_group_id = aws_security_group.neossg.id
}

resource "aws_security_group_rule" "neossgrule4" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.route_dst_cidr_block]
    security_group_id = aws_security_group.neossg.id
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "neosinstance" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.neossubnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.neossg.id]

  depends_on = [
    aws_security_group_rule.neossgrule,
    aws_security_group_rule.neossgrule2,
    aws_security_group_rule.neossgrule3,
    aws_security_group_rule.neossgrule4
  ]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello from Neos Terraform!</h1>" > /var/www/html/index.html
  EOF

  tags = local.common_tags
}
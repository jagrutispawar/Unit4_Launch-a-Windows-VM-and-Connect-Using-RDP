terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "windows_server" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "windows_rdp" {
  name        = "${var.name_prefix}-rdp-sg"
  description = "Allow RDP only from the configured public IPv4 address"
  vpc_id      = var.vpc_id

  ingress {
    description = "RDP from trusted administrator IP only"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_public_ip}/32"]
  }

  egress {
    description = "Allow outbound traffic for Windows updates and management"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-rdp-sg"
  }
}

resource "aws_instance" "windows_vm" {
  ami                         = data.aws_ami.windows_server.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.windows_rdp.id]
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name        = var.name_prefix
    Environment = "Cloud-Security-Lab"
    Assignment  = "Unit-4"
  }
}

variable "aws_region" {
  description = "AWS region in which to create the Windows VM"
  type        = string
  default     = "ap-south-1"
}

variable "name_prefix" {
  description = "Name tag and resource name prefix"
  type        = string
  default     = "windows-cloud-security-vm"
}

variable "instance_type" {
  description = "EC2 instance type supported by the selected Windows AMI"
  type        = string
  default     = "t3.medium"
}

variable "admin_public_ip" {
  description = "Your current public IPv4 address without /32; do not use 0.0.0.0/0"
  type        = string
  sensitive   = true
}

variable "key_pair_name" {
  description = "Name of an existing EC2 key pair in the selected AWS region"
  type        = string
}

variable "vpc_id" {
  description = "ID of an existing VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of a public subnet in the VPC with a route to an Internet Gateway"
  type        = string
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "192.168.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  default     = ["172.16.0.0/24", "172.16.1.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  default     = ["172.16.2.0/24", "172.16.3.0/24"]
}

variable "rds_subnets" {
  description = "List of RDS isolated subnet CIDRs"
  default     = ["172.16.4.0/24", "172.16.5.0/24"]
}

variable "region" {
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "availability_zones" {
  description = "List of availability zones"
  default     = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "your-key-name"
}

variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  description = "ubuntu 20.04 AMI ID for ap-southeast-1"
  default     = "ami-05d2d839d4f73aafb" 
}

variable "key_name" {
  description = "EC2 Key Pair"
  default     = "linux-key"
}
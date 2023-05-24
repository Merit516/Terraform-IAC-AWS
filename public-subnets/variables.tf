
variable "vpc_id" {
  
}
variable "igw_id" {
  
}
variable "public_subnet_cidrs" {

  type        = list(string)
}

variable "availability_zones" {

  type        = list(string)
}
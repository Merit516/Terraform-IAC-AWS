variable "lb_name" {
  default = "public-loadbalancer"
}
variable "lb_type" {
  default = "application"
}
variable "lb_security_gps"{}
variable "lb_subnets" {}
variable "tg_name" {
  default = "public-TG"
}
variable "port" {
  default = 80
}
variable "protocol" {
  default = "HTTP"
}
variable "vpc_id" {}
variable "public_instance_ids" {}
variable "vpc_id" {

}

# variable "public_subnet_cidrs" {

# type = list(string)
# }

variable "private_subnet_cidrs" {

type = list(string)
}

variable "availability_zones" {

type = list(string)
}
variable "nat_gateway_ids" {


}
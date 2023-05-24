#---------------vpc_module--------------------
module "my_vpc"{
  source="./vpc"
  vpc-cidr="10.0.0.0/16"
}


#----------------public_subnets_module-------------------------------
module "public_subnets" {
  source = "./public-subnets"

  vpc_id     = module.my_vpc.vpc_id
  igw_id     =module.my_vpc. igw_id 
  
  
  public_subnet_cidrs = ["10.0.0.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}
#----------------security_group_module------------
module "securtity-group"{
    source="./security-group"
    vpc_id         = module.my_vpc.vpc_id
    name           = "my-security-group"
    description    = "My security group description"
    ingress_rules  = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_rules   = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

#----------------private_subnets_module-------------------------------
module "private_subnets" {
  source = "./private-subnets"

  vpc_id     = module.my_vpc.vpc_id
  #igw_id     =module.my_vpc. igw_id 
  nat_gateway_ids =module.public_subnets.nat_gateway_ids
  
  
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}
module "instance-public"{
  source="./instance-public"
  public_subnet_ids =module.public_subnets.public_subnet_ids
  private_loadbalancer_dns= module.private-loadbalancer.private_loadbalancer_dns
  sg_id             =module.securtity-group.sg_id
  depends_on        = [module.private-loadbalancer]


}
module "instance-private"{
  source="./instance-private"
  private_subnet_ids =module.private_subnets.private_subnet_ids
  sg_id=module.securtity-group.sg_id


}
module "public-loadbalancerr" {
  source          = "./public-loadbalancer"
  vpc_id          = module.my_vpc.vpc_id
  public_instance_ids      = module.instance-public.public_instance_ids
  lb_security_gps = [module.securtity-group.sg_id]
  lb_subnets      = module.public_subnets.public_subnet_ids
  depends_on      = [module.instance-public]
}
module "private-loadbalancer" {
  source          = "./private-loadbalancer"
  vpc_id          = module.my_vpc.vpc_id
  private_instance_ids  = module.instance-private.private_instance_ids
  lb_security_gps = [module.securtity-group.sg_id]
  lb_subnets      = module.private_subnets.private_subnet_ids
  depends_on      = [module.instance-private]
}
#profile details
provider "aws" {
  profile = "485146087273_Auxin-DevOps"
  region  = "us-east-1"
}


terraform {
  backend "s3" {
    bucket = "remote-state-bucket-tf"
    key    = "remote-state-file-tf"
    region = "us-east-1"
    profile = "485146087273_Auxin-DevOps"
  }
}


#creating a module for vpc
module "vpc"  {
    source = "./vpc"
    vpc-cidr = var.vpc-cidr
}


#creating a module for InternetGateway
module "internetgateway" {
    source = "./internet-gateway"
    vpc_id = module.vpc.vpc
}



#module for public subnet #1
module "pub_subnet_1" {
  source = "./subnet"
  vpc_id = module.vpc.vpc
  subnet-cidr = var.pub-subnet1-cidr
  subnet-name = var.pub-subnet1-name
  map_public_ip_on_launch = true
  availability_zone = var.pub_subnet_1_availability_zone
}


#module for public subnet #2
module "pub_subnet_2" {
  source = "./subnet"
  vpc_id = module.vpc.vpc
  subnet-cidr = var.pub-subnet2-cidr
  subnet-name = var.pub-subnet2-name
  map_public_ip_on_launch = true
  availability_zone = var.pub_subnet_2_availability_zone
}




#module for Public route table that is connect with internet gateway
 module "public-route" {
   source = "./routetable"
   vpc_id = module.vpc.vpc
   gateway-id = module.internetgateway.internetgateway
   rt-name = var.public-rt-name
   
 }


 
 #module for route table association for connecting pub_subnet_1 with public-route
 module "pub-rta-1" {
   source = "./routetable-association"
   subnet-id =  module.pub_subnet_1.subnet-id
   route-table-id = module.public-route.routetable
 } 

 #module for route table association for connecting pub_subnet_2 with public-route
 module "pub-rta-2" {
   source = "./routetable-association"
   subnet-id =  module.pub_subnet_2.subnet-id
   route-table-id = module.public-route.routetable
 } 


 

#module for calling puclic ec2 with its security group and nic
module "public_ec2" {
  source = "./public_ec2"
  vpc_id = module.vpc.vpc
  pub_sg_name = var.sg_name_pub_ec2
  subnet_id = module.pub_subnet_1.subnet-id
  private_ip_for_pub_ec2 = var.private_ip_for_pub_ec2
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.pub_key_name
  public_ec2_name = var.public_ec2_name
}

##################################################################



#module for private subnet
module "priv_subnet" {
  source = "./subnet"
  vpc_id = module.vpc.vpc
  subnet-cidr = var.priv-subnet-cidr
  subnet-name = var.priv-subnet-name
  map_public_ip_on_launch = false
  availability_zone = var.priv_subnet_availability_zone
}


#module for Private route table that is connect with nat gateway
module "private-route" {
  source = "./routetable"
  vpc_id = module.vpc.vpc
  gateway-id = module.natgateway.ngw
  rt-name = var.private-rt-name
}


#module for route table association for private route table
 module "priv-rta" {
   source = "./routetable-association"
   subnet-id =  module.priv_subnet.subnet-id
   route-table-id = module.private-route.routetable
 } 


#module for nat-gateway

module "natgateway" {
  source = "./nat-gateway"
  pub-subnet = module.pub_subnet_1.subnet-id
}



#module for calling Application load balancer
module "application_load_balancer" {
  source = "./alb"
  vpc_id = module.vpc.vpc
  alb_sg_name = var.alb_sg_name
  alb_name = var.alb_name
  load_balancer_type = var.load_balancer_type
  public_subnet = [module.pub_subnet_1.subnet-id, module.pub_subnet_2.subnet-id]
  alb_tg_name = var.alb_tg_name
}



#module for Autoscaling Group
module "autoscaling" {
  source = "./autoscaling"
  vpc_id = module.vpc.vpc
  asg_sg_name = var.asg_sg_name
  launch_confg_name = var.launch_confg_name
  image_id = var.ami
  instance_type = var.instance_type
  asg_launch_confg_key_name = var.asg_launch_confg_key_name
  asg_name = var.asg_name
  max_size = var.max_size
  min_size = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type = var.health_check_type
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = [module.priv_subnet.subnet-id]
  #Here we attached our Asg with target group of ALB. So the ec2 instance that will be created through this ASG will be attached to Target Group of ALB.. 
  # ALB Target_ Group ==> ASG ==> Ec2 Instance Running Inside ASG
  alb_target_group_arns = [module.application_load_balancer.aws_lb_target_group]
}


 
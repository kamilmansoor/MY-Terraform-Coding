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



#module for public subnet
module "pub_subnet" {
  source = "./subnet"
  vpc_id = module.vpc.vpc
  subnet-cidr = var.pub-subnet-cidr
  subnet-name = var.pub-subnet-name
  map_public_ip_on_launch = true
}


#module for Public route table that is connect with internet gateway
 module "public-route" {
   source = "./routetable"
   vpc_id = module.vpc.vpc
   gateway-id = module.internetgateway.internetgateway
   rt-name = var.public-rt-name
   
 }



 #module for route table association for public route table
 module "pub-rta" {
   source = "./routetable-association"
   subnet-id =  module.pub_subnet.subnet-id
   route-table-id = module.public-route.routetable
 } 



#module for calling puclic ec2 with its security group and nic
module "public_ec2" {
  source = "./public_ec2"
  vpc_id = module.vpc.vpc
  pub_sg_name = var.sg_name_pub_ec2
  subnet_id = module.pub_subnet.subnet-id
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
  pub-subnet = module.pub_subnet.subnet-id
}


#module for calling private ec2 with its security group and nic
module "private_ec2" {
  source = "./private_ec2"
  vpc_id = module.vpc.vpc
  priv_sg_name = var.sg_name_priv_ec2
  subnet_id = module.priv_subnet.subnet-id
  private_ip_for_priv_ec2 = var.private_ip_for_priv_ec2
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.priv_key_name
  private_ec2_name = var.private_ec2_name
}






 
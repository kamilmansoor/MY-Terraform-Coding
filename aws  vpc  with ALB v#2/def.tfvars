vpc-cidr = "192.167.0.0/16"

pub-subnet1-cidr = "192.167.1.0/24"

pub-subnet1-name = "kamil_pub_subnet1"

pub_subnet_1_availability_zone = "us-east-1a"

pub-subnet2-cidr = "192.167.2.0/24"

pub-subnet2-name = "kamil_pub_subnet2"

pub_subnet_2_availability_zone = "us-east-1b"

public-rt-name = "kamil_pub_rt"

sg_name_pub_ec2 = "sg_for_pub_ec2"

private_ip_for_pub_ec2 = "192.167.1.11"

ami = "ami-0c4f7023847b90238"

instance_type = "t2.micro"

pub_key_name = "new_key_pair"

public_ec2_name = "kamil_pub_ec2_instance"

########################################33
priv-subnet-cidr = "192.167.5.0/24"

priv-subnet-name = "kamil_priv_subnet"

priv_subnet_availability_zone = "us-east-1a"

private-rt-name = "kamil_priv_rt"

sg_name_priv_ec2 = "sg_for_priv_ec2"

private_ip_for_priv_ec2 = "192.167.5.11"

priv_key_name = "private_key"

private_ec2_name = "kamil_priv_ec2_instance"

#####  After ALB #######

alb_sg_name = "alb_sg_name"

alb_name = "my-application-lb"

load_balancer_type = "application"

alb_tg_name = "my-application-lb-tg"
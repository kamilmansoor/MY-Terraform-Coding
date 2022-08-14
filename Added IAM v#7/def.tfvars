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
priv-subnet1-cidr = "192.167.3.0/24"

priv-subnet1-name = "kamil_priv_subnet_1"

priv_subnet_1_availability_zone = "us-east-1a"

priv-subnet2-cidr = "192.167.4.0/24"

priv-subnet2-name = "kamil_priv_subnet_2"

priv_subnet_2_availability_zone = "us-east-1b"

private-rt-name = "kamil_priv_rt"



#####  After ALB #######

alb_sg_name = "alb_sg_name"

alb_name = "my-application-lb"

load_balancer_type = "application"

alb_tg_1_name = "my-application-lb-tg-1"

alb_tg_2_name = "my-application-lb-tg-2"


#### After ASG ######

asg_sg_name = "asg_security_group"

launch_confg_name = "asg_configuration"

asg_launch_confg_key_name = "private_key"

asg_1_name = "kamil_asg_1"

max_size = "1"

min_size = "1"

health_check_grace_period = "30"

health_check_type = "EC2"

desired_capacity = "1"

asg_2_name = "kamil_asg_2"



### RDS ###

rds_sg_name = "rds_sg"

db_name =  "kamil_rds"

allocated_storage = "20"

storage_type = "gp2"

db_engine = "mariadb"

db_identifier = "alphascale"

db_engine_version = "10.3.31"

db_instance_class = "db.t3.micro"

db_username = "kamildb"

db_password = "kamildb123"

rds_az_name = "us-east-1a"


### iam ###

ec2_role_name ="iam-role-kamil"

name_instance_profile = "iam-profile-kamil"

ec2_attach_role_list = [
  "arn:aws:iam::aws:policy/AmazonS3FullAccess"
]
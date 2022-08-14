variable "vpc-cidr" {
    type = string
}

variable "pub-subnet1-cidr" {
    type = string
}


variable "pub-subnet1-name" {
    type = string
}


variable "pub_subnet_1_availability_zone" {
    type = string
}

variable "pub-subnet2-cidr" {
    type = string
}


variable "pub-subnet2-name" {
    type = string
}


variable "pub_subnet_2_availability_zone" {
    type = string
}


variable "public-rt-name" {
    type = string
}


variable "sg_name_pub_ec2" {
    type = string
}

variable "private_ip_for_pub_ec2" {
    type = string
}

variable "ami" {
    type = string
}


variable "instance_type" {
    type = string
}


variable "pub_key_name" {
    type = string
}


variable "public_ec2_name" {
    type = string
}

#######################################

variable "priv-subnet1-cidr" {
    type = string
}


variable "priv-subnet1-name" {
    type = string
}

#new
variable "priv_subnet_1_availability_zone" {
    type = string
}

variable "priv-subnet2-cidr" {
    type = string
}

variable "priv-subnet2-name" {
    type = string
}

variable "priv_subnet_2_availability_zone" {
    type = string
}


variable "private-rt-name" {
    type = string
}





##### After ALB ###########


variable "alb_sg_name" {
    type = string
}

variable "alb_name" {
    type = string
}


variable "load_balancer_type" {
    type = string
}


variable "alb_tg_1_name" {
    type = string
}

variable "alb_tg_2_name" {
    type = string
}


####### Autoscaling ########

variable "asg_sg_name" {
    type = string
}

variable "launch_confg_name" {
    type = string
}

variable "asg_launch_confg_key_name" {
    type = string
}


variable "asg_1_name" {
    type = string
}

variable "max_size" {
    type = string
}

variable "min_size" {
    type = string
}

variable "health_check_grace_period" {
    type = string
}

variable "health_check_type" {
    type = string
}

variable "desired_capacity" {
    type = string
}

variable "asg_2_name" {
    type = string
}


### RDS ###

variable "rds_sg_name" {
    type = string
}

variable "db_name" {
    type = string
}

variable "allocated_storage" {
    type = string
}


variable "storage_type" {
    type = string
}


variable "db_engine" {
    type = string
}


variable "db_identifier" {
    type = string
}


variable "db_engine_version" {
    type = string
}


variable "db_instance_class" {
    type = string
}

variable "db_username" {
    type = string
}

variable "db_password" {
    type = string
}

variable "rds_az_name" {
    type = string
}

### iam  ####

#set the name of the role 
variable "ec2_role_name" {
  type        = string
}

#set the instance profile 
variable "name_instance_profile" {
  type        = string
}

variable "ec2_attach_role_list" {
  type = set(string)
}
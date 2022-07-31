variable "vpc_id" {
    type = string
}

variable "asg_sg_name" {
    type = string
}

variable "launch_confg_name" {
    type = string
}

variable "image_id" {
    type = string
}

variable "instance_type" {
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

variable "vpc_zone_identifier" {
    type = list(string)
}

variable "alb_target_group_1_arns" {
    type = set(string)
}



variable "asg_2_name" {
    type = string
}


variable "alb_target_group_2_arns" {
    type = set(string)
}

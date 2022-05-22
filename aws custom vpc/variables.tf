variable "vpc-cidr" {
    type = string
}

variable "pub-subnet-cidr" {
    type = string
}


variable "pub-subnet-name" {
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

variable "priv-subnet-cidr" {
    type = string
}


variable "priv-subnet-name" {
    type = string
}

variable "private-rt-name" {
    type = string
}

variable "sg_name_priv_ec2" {
    type = string
}

variable "private_ip_for_priv_ec2" {
    type = string
}

variable "priv_key_name" {
    type = string
}

variable "private_ec2_name" {
    type = string
}


variable "vpc_id" {
    type = string
}

variable "subnet-cidr" {
    type = string
}

variable "subnet-name" {
    type = string
}

variable "map_public_ip_on_launch" {
    type = bool
}

variable "availability_zone" {
    type = string
}
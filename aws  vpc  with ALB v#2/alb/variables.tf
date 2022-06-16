variable "vpc_id" {
    type = string
}

variable "alb_sg_name" {
    type = string
}

variable "alb_name" {
    type = string
}

variable "load_balancer_type" {
    type = string
}

variable "public_subnet" {
  type = list(string)
}

variable "alb_tg_name" {
    type = string
}

variable "target_aws_instance_id" {
    type = string
}
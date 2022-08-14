variable "rds_sg_name" {
    type = string
}

variable "vpc_id" {
    type = string
}

#set the private subnet ids
variable "private_subnet_ids" {
  description = "List of Private Subnet ID"
  type        = list(string)
  sensitive   = true
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

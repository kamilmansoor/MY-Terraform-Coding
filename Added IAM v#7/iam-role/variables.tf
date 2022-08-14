#set the name of the role 
variable "ec2_role_name" {
  description = "Role name"
  type        = string
}

#set the instance profile 
variable "name_instance_profile" {
  description = "name_instance_profile"
  type        = string
}

variable "ec2_attach_role_list" {
  type = set(string)
}
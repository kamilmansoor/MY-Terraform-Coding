#attach the role name 
variable "role" {
  description = "Role name"
  type        = string
}

variable "attach_role_list" {
  type = set(string)
}
#create a role for the backend machine
module "ec2-role" {
  source = "./role"

  #set the role name
  role_name = var.ec2_role_name

}

# Attach the policies to the role
module "attach-policy" {
  source = "./policy"

  # Set the role name and attach the policies to the role
  role = module.ec2-role.role_name

  # Attach a predefined AWS policies
  attach_role_list = var.ec2_attach_role_list
}

# Creeate an instance profile for the role to attach it to the backend machine
module "instance-profile" {
  source = "./profile"

  #set the role name and instance profile name
  role         = module.ec2-role.role_name
  name_profile = var.name_instance_profile

 
}
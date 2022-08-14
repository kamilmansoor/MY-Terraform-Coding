#create a instance profile 
resource "aws_iam_instance_profile" "backend-ec2-profile" {

  #set the name of the instance profile
  name = var.name_profile

  #attach the role name
  role = var.role

}
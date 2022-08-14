#attach the  secret policy to the role
resource "aws_iam_role_policy_attachment" "role-attachment" {

  #attach the role name
  role = var.role

  # Set the list in one shot
  for_each = var.attach_role_list

  policy_arn = each.key
}
#output for secret role name
output "role_name" {
  value = aws_iam_role.as-iam-role.name
}

#output for secret role arn
output "role_arn" {
  value = aws_iam_role.as-iam-role.arn
}
output "iam-profile-id" {
  value = aws_iam_instance_profile.backend-ec2-profile.id
}

output "iam-profile-name" {
  value = aws_iam_instance_profile.backend-ec2-profile.name
}
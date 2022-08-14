#create a role  for the backend machine
resource "aws_iam_role" "as-iam-role" {

  #set the name of the role
  name = var.role_name

  #assume the role policy for instance
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}
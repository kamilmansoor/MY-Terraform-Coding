In this version of code i have attached the iam_role_profile with the autoscaling group machines, this role has policy attached(policy for s3 full access) so that machines can access the resources like S3 ... etc. You can attach other managed policies as well. To confirm this go inside any private machine in asg and run command: aws s3 ls, you'll see list of all buckets present in s3 in the current account. 

There can be managed policies from aws as well as the inline policies.

Managed policies:
----------------
These are builtin policies, already created for us by aws, we can use them by simply using their arn values like "arn:aws:iam::aws:policy/AmazonS3FullAccess"

Inline policies:
----------------
policies which we have to create manually like for cross account access stuff etc..


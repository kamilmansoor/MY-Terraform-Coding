custom_aws_vpc
INSTRUCTIONS TO FOLLOW TO EXECUTE THIS CODE

STEP#1: INSTALLATIONS: choco => terraform => aws cli => vscode(with terraform extension) Go to cmd: aws configure Create a profile: aws configure --profile

#################################################################################################################

STEP#2: clone this code locally STEP#3: Few resources need to be create manually as per this infrastructure: 1- Keypair for both public and private vm. 2- Remote backend S3 (you have to create a s3 bucket manually and copy paste its name inside your main configuration file at the root level).

STEP#4:

terraform init => terraform plan => terraform apply

SSh from public vm to private vm command link => https://www.youtube.com/watch?v=OwptfrdgzDA

The end!

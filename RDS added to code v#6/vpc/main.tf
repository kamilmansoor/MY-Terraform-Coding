#create a vpc 
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = "kamil_vpc"
  }
}
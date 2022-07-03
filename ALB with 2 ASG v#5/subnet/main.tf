#create public subnets
resource "aws_subnet" "subnets" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet-cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone = var.availability_zone

  tags = {
    Name = var.subnet-name
  }
}



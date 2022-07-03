#Creating the route table (public and private both)
resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway-id
  }


  tags = {
    Name = var.rt-name

  }
}
#creating elastic ip for nat gateway

resource "aws_eip" "eip" {
  vpc      = true
}

resource "aws_nat_gateway" "ng" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.pub-subnet

  tags = {
    Name = "kamil-gw-NAT"
  }
}  
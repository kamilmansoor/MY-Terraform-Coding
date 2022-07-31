#create internetgateway
resource "aws_internet_gateway" "gw" {
  vpc_id = var.hello
  tags = {
    Name = "kamil_gw"
  }
}

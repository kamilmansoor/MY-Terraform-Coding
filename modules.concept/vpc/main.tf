#create a vpc 
resource "aws_vpc" "main" {
  cidr_block = var.umer

  tags = {
    Name = "kamil_vpc"
  }
}

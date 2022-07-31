#create a route table association in which route table is associated with the subnet 
resource "aws_route_table_association" "rta" {
  subnet_id      = var.subnet-id
  route_table_id = var.route-table-id
}
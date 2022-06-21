#Security Group for the private ec2 machine


resource "aws_security_group" "priv_sg" {
  name        = var.private_ec2_sg_name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.167.0.0/16"]
  }

  #The ALB-target-group port needs to be same as of ALB-target-group-attachment as well as target-aws-instance-ingress i.e port 8081. Inside private_ec2 our jenkins service will be runing on port 8081

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.167.0.0/16"]

  }
  
  ingress {
    description = "TLS from VPC"
    from_port   = 50
    to_port     = 50
    protocol    = "tcp"
    cidr_blocks = ["192.167.0.0/16"]

  }



  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

#Creating the Network Interface Card for the Private EC2 MACHINE
resource "aws_network_interface" "priv_nic" {
  subnet_id       = var.subnet_id
  private_ips     = [var.private_ip_for_priv_ec2]
  security_groups = [aws_security_group.priv_sg.id]
}

resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  network_interface {
    network_interface_id = aws_network_interface.priv_nic.id
    device_index         = 0
  }
  
  tags = {
    Name = var.private_ec2_name
  }
}

#Security Group for the private ec2 machine


resource "aws_security_group" "priv_sg" {
  name        = "allow_priv_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.167.0.0/16"]
  }

 #The port for ALB-target-group needs to be same as for ALB-target-group-attachment as well as for the ingress port of the instance(private_ec2) that is attach to ALB  

  ingress {
    description = "TLS from VPC"
    from_port   = 8081
    to_port     = 8081
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

  tags = {
    Name = var.priv_sg_name
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

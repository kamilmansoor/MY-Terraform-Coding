#profile details
provider "aws" {
  profile = "485146087273_Auxin-DevOps"
  region  = "us-east-1"
}



#create a vpc 
resource "aws_vpc" "main" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = "kamil_vpc"
  }
}

#For Public Facing
#create internetgateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "kamil_gw"
  }
}

#create Public subnet
resource "aws_subnet" "pub_sub" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub-subnet-cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "kamil_Public_subnet"
  }
}


#create public route_table in which route table is associated with internet gateway
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "kamil_public_rt"

  }
}

#create a route table association in which route table is associated with the subnet 
resource "aws_route_table_association" "pub-rta" {
  subnet_id      = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.example.id
}

#####################################################################################
#For Private Facing
#NAT Gateway EIP

resource "aws_eip" "nateip" {
  vpc = true

  tags = {
    Name = "my_eip"

  }
}


#NAT Gateway 

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nateip.id
  subnet_id     = aws_subnet.pub_sub.id

  tags = {
    Name = "kamil-NGW"
  }
}

#create Private subnet
resource "aws_subnet" "priv_sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.priv-subnet-cidr

  tags = {
    Name = "kamil_private_subnet"
  }
}

#create private_route table
resource "aws_route_table" "priv" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }


  tags = {
    Name = "kamil_priv_rt"

  }
}

#create a private route table association 
resource "aws_route_table_association" "priv-rta" {
  subnet_id      = aws_subnet.priv_sub.id
  route_table_id = aws_route_table.priv.id
}

#Security Group for the Public ec2 machine

resource "aws_security_group" "pub_sg" {
  name        = "allow_pub_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Pub_SG_EC2"
  }
}



#Creating the Network Interface Card for the Public EC2 MACHINE
resource "aws_network_interface" "pub_nic" {
  subnet_id       = aws_subnet.pub_sub.id
  private_ips     = ["192.168.1.10"]
  security_groups = [aws_security_group.pub_sg.id]
  # attachment {
  #   instance     = aws_instance.machine.id
  #   device_index = 1
  # }
}

#Creating a public EC2 machine
resource "aws_instance" "pub_machine" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name      = "my_key"
  network_interface {
    network_interface_id = aws_network_interface.pub_nic.id
    device_index         = 0
  }

  tags = {
    Name = "MY_EC2"
  }
}


#Security Group for the Private ec2 machine

resource "aws_security_group" "priv_sg" {
  name        = "allow_priv_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "priv_SG_EC2"
  }
}


#Creating the Network Interface Card for the Private EC2 MACHINE
resource "aws_network_interface" "priv_nic" {
  subnet_id       = aws_subnet.priv_sub.id
  private_ips     = ["192.168.4.10"]
  security_groups = [aws_security_group.priv_sg.id]
  # attachment {
  #   instance     = aws_instance.machine.id
  #   device_index = 1
  }


#Creating a private EC2 machine
resource "aws_instance" "priv_machine" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name      = "my_key"  
  network_interface {
    network_interface_id = aws_network_interface.priv_nic.id
    device_index         = 0
  }

  tags = {
    Name = "MY_EC2"
  }
}


####################################### NEW TASK #################################


















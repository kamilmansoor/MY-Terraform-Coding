#Security Group for the public ec2 machine

resource "aws_security_group" "pub_sg" {
  name        = "allow_pub_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
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
    Name = var.pub_sg_name
  }
}


#Creating the Network Interface Card for the Public EC2 MACHINE
resource "aws_network_interface" "pub_nic" {
  subnet_id       = var.subnet_id
  private_ips     = [var.private_ip_for_pub_ec2]
  security_groups = [aws_security_group.pub_sg.id]

}




resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  network_interface {
    network_interface_id = aws_network_interface.pub_nic.id
    device_index         = 0
  }
  user_data =  <<-EOF
                #https://aws.amazon.com/premiumsupport/knowledge-center/execute-user-data-ec2/ 
                Content-Type: multipart/mixed; boundary="//"
                MIME-Version: 1.0
                --//
                Content-Type: text/cloud-config; charset="us-ascii"
                MIME-Version: 1.0
                Content-Transfer-Encoding: 7bit
                Content-Disposition: attachment; filename="cloud-config.txt"
                #cloud-config
                cloud_final_modules:
                - [scripts-user, always]
                --//
                Content-Type: text/x-shellscript; charset="us-ascii"
                MIME-Version: 1.0
                Content-Transfer-Encoding: 7bit
                Content-Disposition: attachment; filename="userdata.txt"
                #!/bin/bash 
                mkdir -p /home/ubuntu/yasirfolder
                echo "kamil is a bad boy" > /home/ubuntu/saad.txt

  EOF

  tags = {
    Name = var.public_ec2_name
  }
}
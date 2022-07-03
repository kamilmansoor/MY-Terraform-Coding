#Security Group for the autoscaling group

resource "aws_security_group" "asg_sg" {
  name        = var.asg_sg_name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.167.0.0/16"]
  }

   ingress {
    description = "TLS from VPC"
    #alb_tg_1 will route request to target web server instances on HTTP port 80
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.167.0.0/16"]

  }

  ingress {
    description = "TLS from VPC"
    #alb_tg_2 will route request to target web server instances on HTTP port 50
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

  tags = {
    Name = var.asg_sg_name
  }
}

### ASG launch Configuration ######

resource "aws_launch_configuration" "asg_launch_confg" {
  name          = var.launch_confg_name
  image_id      = var.image_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.asg_sg.id]
  key_name = var.asg_launch_confg_key_name
}

### Auto Scaling Group #1 ######

resource "aws_autoscaling_group" "asg_1" {
  name                      = var.asg_1_name
  max_size                  = var.max_size 
  min_size                  = var.min_size 
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = true
  launch_configuration      = aws_launch_configuration.asg_launch_confg.id
  vpc_zone_identifier       = var.vpc_zone_identifier 
  #Here we attached our 1st Asg with 1st target group of ALB. So the ec2 instance that will be created through this 1st ASG will be attached to 1st Target Group of ALB.. 
  # ALB Target_ Group_1 ==> ASG_1 ==> Ec2 Instance Running Inside ASG_1
  target_group_arns         = var.alb_target_group_1_arns 
}

### Auto Scaling Group #2 ######

resource "aws_autoscaling_group" "asg_2" {
  name                      = var.asg_2_name
  max_size                  = var.max_size 
  min_size                  = var.min_size 
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = true
  launch_configuration      = aws_launch_configuration.asg_launch_confg.id
  vpc_zone_identifier       = var.vpc_zone_identifier 
  #Here we attached our 2nd Asg with 2nd target group of ALB. So the ec2 instance that will be created through this 2nd ASG will be attached to 2nd Target Group of ALB.. 
  # ALB Target_ Group_2 ==> ASG_2 ==> Ec2 Instance Running Inside ASG_2
  target_group_arns         = var.alb_target_group_2_arns 
}
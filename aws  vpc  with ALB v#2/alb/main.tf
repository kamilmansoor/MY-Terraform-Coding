
#Security Group for Application Load balancer
resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

#the port for the ALB-SG ingress needs to be same as of ALB-LISTNER
  ingress {
    description = "allow http"
    from_port   = 50 
    to_port     = 50
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
    Name = var.alb_sg_name
  }
}



#Application Load Balancer

resource "aws_lb" "application_load_balancer" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            =  var.public_subnet
}

#Application Load Balancer Target Group
#Traffic will be routed to target web server instances on HTTP port 8081
#The port for ALB-target-group needs to be same as for ALB-target-group-attachment as well as for the engress port of the instance(private_ec2) that is attach to ALB 

resource "aws_lb_target_group" "alb_tg" {
  name     = var.alb_tg_name
  port     = 8081
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

#ALb target Group attachment 
resource "aws_lb_target_group_attachment" "alb_tg_attachment" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = var.target_aws_instance_id
  port             = 8081
}



#Application Load Balancer Listener

resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  #the port for the ALB-SG ingress needs to be same as of ALB-LISTNER
  port              = "50"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}




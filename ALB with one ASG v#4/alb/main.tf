
#Security Group for Application Load balancer
resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

#The ALB-SG-ingress port needs to be same as of ALB-Listener
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

#Application Load Balancer Target Group. We need to attach this target group with Autoscaling Group
#Traffic will be routed to target web server(created through ASG) on HTTP port 8081 

resource "aws_lb_target_group" "alb_tg" {
  name     = var.alb_tg_name
  port     = 8081
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}



#Application Load Balancer Listener
#The ALB-SG-ingress port needs to be same as of ALB-Listener

resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}




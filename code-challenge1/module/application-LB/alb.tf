# Create security group for the ALB.

resource "aws_security_group" "main-alb-sg" {
  vpc_id = var.krishi_project_vpc_id
  
   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "MAIN-ALB-Security-Group"  
  } 
}

# Create The ALB
resource "aws_lb" "main-alb" {
    name = "main-ALB"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.main-alb-sg.id]
    subnets = [
      var.pub_subnet_1A,
      var.pub_subnet_1B
      ]
  enable_deletion_protection = false
  tags = {
    Name = "main-APP-LB"
  }
}

# Create ALB Listner - HTTPS
resource "aws_lb_listener" "main-alb-listener" {
  load_balancer_arn = aws_lb.main-alb.arn
  port = 443
  protocol = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-0-2015-04"
  certificate_arn   = "arn:aws:acm:eu-west-1:824428235744:certificate/c5f585f4-9b7e-42b7-937d-3288785856c6"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.main-alb-fetg.arn
  }
}

# Create ALB Listner Backend Rule - HTTPS

resource "aws_lb_listener_rule" "main-alb-listener" {
  listener_arn = aws_lb_listener.main-alb-listener.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main-alb-betg.arn
  }
    condition {
    path_pattern {
      values = ["/admin*"]
    }
  }
}





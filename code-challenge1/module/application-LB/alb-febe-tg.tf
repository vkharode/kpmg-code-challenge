# Create Frontend Target Group
resource "aws_lb_target_group" "main-alb-fetg" {
  port = 80
  protocol = "HTTP"
  name = "main-alb-target-group"
  vpc_id = var.main_vpc_id
  stickiness {
    type = "lb_cookie"
    enabled = true
  }
  health_check {
    protocol = "HTTP"
    path = "/healthy.html"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
  }
  tags = {
    Name = "MAIN-FRONT-END-TARGET-GROUP"  
  } 
}

# Create Backend Target Group
resource "aws_lb_target_group" "main-alb-betg" {
  port = 80
  protocol = "HTTP"
  name = "main-alb-target-group"
  vpc_id = var.main_vpc_id
  stickiness {
    type = "lb_cookie"
    enabled = true
  }
  health_check {
    protocol = "HTTP"
    path = "/healthy.html"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
  }
  tags = {
    Name  = "MAIN-BACK-END-TARGET-GROUP"
  } 
}
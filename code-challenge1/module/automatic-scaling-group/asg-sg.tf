 # Create Security Group for ASG
resource "aws_security_group" "main-asg-sg" {
  vpc_id = var.main_vpc_id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
 ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [
      var.aws_alb_sg_id
    ]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [
      var.aws_alb_sg_id
    ]
  }
  tags = {
    Name = "MAIN-ASG-Security-Group"
  } 
}

# Create Launch Configuration
resource "aws_launch_configuration" "main-asg-launch-config" {
  name_prefix   = "MAIN-ASG-Launch-Configuration"
  image_id      = var.asg_image_id
  instance_type = var.asg_instance_type
  security_groups = [aws_security_group.main-asg-sg.id]
  key_name = "Migration"
  lifecycle {
    create_before_destroy = true
  }
}

# Create DFSC FrontEnd ASG
resource "aws_autoscaling_group" "main-asg-fe" {
  name                 = "MAIN-ASG-FE-Pre"
  launch_configuration = aws_launch_configuration.main-asg-launch-config.name
  health_check_type    = "ELB"
  min_size             = 0
  max_size             = 0
  desired_capacity     = 0

  vpc_zone_identifier = [
    var.private_subnet_1A,
    var.private_subnet_1B
  ]
  target_group_arns = [var.aws_alb_fe_arn]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "MAIN-ASG-FE"
    propagate_at_launch = true  
  }
}

# Create DFSC Backend ASG

resource "aws_autoscaling_group" "main-asg-be" {
  name                 = "MAIN-ASG-BE-Pre"
  launch_configuration = aws_launch_configuration.main-asg-launch-config.name
  health_check_type    = "ELB"
  min_size             = 0
  max_size             = 0
  desired_capacity     = 0

  vpc_zone_identifier = [
    var.private_subnet_1A,
    var.private_subnet_1B
  ]
  target_group_arns = [var.aws_alb_be_arn]
  lifecycle {
    create_before_destroy = true
  }
 tag {
    key                 = "Name"
    value               = "MAIN-ASG-BE"
    propagate_at_launch = true  
  }
}
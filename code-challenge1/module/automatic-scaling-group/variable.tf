variable "main_vpc_id" {
    type = string
    default = ""
}

variable "asg_image_id" {
    type = string
    default = ""
}

variable "asg_instance_type" {
    type = string
    default = "test"
}

variable "private_subnet_1A" {
    type = string
    default = "test"
}

variable "private_subnet_1B" {
    type = string
    default = ""
}

variable "aws_alb_fe_arn" {
    type = string
    default = ""
}

variable "aws_alb_be_arn" {
    type = string
    default = ""
}

variable "aws_alb_sg_id" {
  type = string
  default = ""
}
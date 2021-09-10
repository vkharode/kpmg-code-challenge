# create a VPC Network for main project

resource "aws_vpc" "main-vpc" {
    cidr_block = var.main_vpc_cidr
    instance_tenancy = "default"
    tags = {
      "Name" = var.tag_name
    }
}

resource "aws_iam_role" "main-iam-role" {
  name = "main-IAM-ROLE"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "main-iam-policy" {
  name = "main-IAM-POLICY"
  role = aws_iam_role.main-iam-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "main-log-group" {
  name = "main-LOG-GRP"
}

resource "aws_flow_log" "main-vpc-flowlog" {
  iam_role_arn    = aws_iam_role.main-iam-role.arn
  log_destination = aws_cloudwatch_log_group.main-log-group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main-vpc.id
  tags = {
    "Name" = "main-LOGS"
  }
  depends_on = [
    aws_vpc.main-vpc, aws_cloudwatch_log_group.main-log-group, aws_iam_role.main-iam-role
  ]
}

resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    "Name" = "main-IGW"
  }
}



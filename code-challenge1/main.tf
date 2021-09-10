module "network" {
    source = "./module/network"
    main_vpc_cidr = "10.0.0.0/24"
    tag_name = "MAIN-UAT-ENV"
    pub_subnet1a_cidr = "10.0.0.128/26"
    pub_subnet1b_cidr = "10.0.0.204/26"
    priv_subnet1a_cidr = "10.0.0.192/26"
    priv_subnet1b_cidr = "10.0.0.152/26"
}

module "app-lb" {
    source = "./module/application"
    main_vpc_id = module.network.main_vpc_id
    pub_subnet_1A = module.network.public_subnet1A_id
    pub_subnet_1B = module.network.public_subnet1B_id
}

module "automatic-scaling-group" {
    source = "./module/automatic-scaling-group"
    main_vpc_id = module.network.main_vpc_id
    private_subnet_1A = module.network.private_subnet1A_id
    private_subnet_1B = module.network.private_subnet1B_id
    aws_alb_fe_arn = module.application.aws_alb_fe_arn
    aws_alb_be_arn = module.application.aws_alb_be_arn
    aws_alb_sg_id = module.application.aws_alb_sg_id
}

# CREATE MAIN RDS SECURITY GROUP

resource "aws_security_group" "main-db-sg" {
  name = "main-RDS-Security-Group"
  vpc_id = module.network.main_vpc_id
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [
      aws_security_group.main-db-sg.id
    ]
  }
  tags = {
    Name        = "MAIN-Security-Group"
  }
}

# Create MAIN PROJECT Database Subnet Group

resource "aws_db_subnet_group" "main-db-subnet" {
  name = "main-database-subnet-group"
  subnet_ids = [
    aws_subnet.module.network.private_subnet1A_id,
    aws_subnet.module.network.private_subnet1A_id
    ]

  tags = {
    Name        = "DB Subnet Group"
    Terraform   = "true"
  }
}

# Create main PROJECT Database Instance 

resource "aws_db_instance" "main-db" {
  allocated_storage       = "10"
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.6"
  multi_az                = "true"
  instance_class          = "db.t2.micro"
  name                    = "magento"
  username                = "admin"
  password                = var.db-master-password
  identifier              = "main-database"
  skip_final_snapshot     = "true"
  backup_retention_period = "7"
  port                    = "3306"
  storage_encrypted       = "false"
  db_subnet_group_name    = aws_db_subnet_group.main-db-subnet.name
  vpc_security_group_ids  = [aws_security_group.main-db-sg.id]
   tags = {
    Name        = "MAIN PROJECT Database"
    Terraform   = "true"
  }
}
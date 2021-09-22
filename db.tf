module "db" {
  source  = "terraform-aws-modules/rds/aws"
#   version = "~> 3.0"

  identifier = "group3-mysql-db-1"

  engine            = "mysql"
  engine_version    = "8.0.23"
  instance_class    = "db.t2.micro"
  allocated_storage = 20

  name     = "examdb"
  username = "admin"
  password = "password"
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [aws_security_group.allow_tls1.id]

#   maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  backup_retention_period = 7

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
#   monitoring_interval = "30"
#   monitoring_role_name = "MyRDSMonitoringRole"
#   create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  subnet_ids = module.vpc.private_subnets

#   # DB parameter group
  family = "mysql8.0"

#   # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = true
  publicly_accessible = false
  multi_az = true

#   parameters = [
#     {
#       name = "character_set_client"
#       value = "utf8mb4"
#     },
#     {
#       name = "character_set_server"
#       value = "utf8mb4"
#     }
#   ]

  depends_on = [
    module.vpc
  ]
}
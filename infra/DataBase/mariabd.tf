resource "random_password" "bd_password" {
  min_lower   = 1
  min_upper   = 1
  min_special = 1
  length      = 25
  special     = true
}


resource "aws_db_subnet_group" "db_subnet" {
  name       = var.db_subnet_group_name
  subnet_ids = [var.db_subnet_id, var.prv_subnet_id]

  #tags = var.tags
}

resource "aws_db_instance" "database" {
  allocated_storage = var.allocated_storage
  engine            = var.db_engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  name              = var.DBName
  username          = var.db_username
  password          = random_password.bd_password.result


  vpc_security_group_ids = [var.security_group_rds_sg_id]

  db_subnet_group_name = aws_db_subnet_group.db_subnet.id

  storage_encrypted   = false
  skip_final_snapshot = true
  publicly_accessible = false
  multi_az            = false

  #tags = vars.tags
}
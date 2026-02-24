resource "aws_security_group" "rds_sg" {
  name        = "${var.name}-rds-sg"
  description = "RDS access from app SG only"
  vpc_id      = var.vpc_id

  tags = { Name = "${var.name}-rds-sg" }
}

resource "aws_security_group_rule" "rds_in_from_app" {
  type                     = "ingress"
  security_group_id        = aws_security_group.rds_sg.id
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  source_security_group_id = var.app_sg_id
}

resource "aws_security_group_rule" "rds_all_out" {
  type              = "egress"
  security_group_id = aws_security_group.rds_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnets"
  subnet_ids = var.private_subnet_ids

  tags = { Name = "${var.name}-db-subnets" }
}


resource "random_password" "db" {
  length  = 24
  special = true
}

resource "aws_secretsmanager_secret" "db" {
  name = "${var.name}-db-credentials"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.db.result
    engine   = var.engine
    port     = var.port
    dbname   = var.db_name
  })
}

resource "aws_db_instance" "this" {
  identifier = "${var.name}-db"

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  db_name  = var.db_name
  username = var.username
  password = random_password.db.result
  port     = var.port

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false
  multi_az            = var.multi_az

  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = var.skip_final_snapshot

  storage_encrypted = true

  tags = { Name = "${var.name}-db" }
}
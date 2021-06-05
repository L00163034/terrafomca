resource "aws_security_group" "general_sg" {
  description = "HTTP egress to anywhere"
  vpc_id      = var.vpc_id

  #tags = var.tags
}

resource "aws_security_group" "rds_sg" {
  # database is exposed to bastion and apps vms
  description = "MariaDb ingress rules"
  vpc_id      = var.vpc_id
  #tags        = var.tags
}

resource "aws_security_group" "bastion_sg" {
  # bastion is exposed to outside of the network
  # eg. mail, dns, web, ftp
  description = "SSH ingress to Bastion and SSH egress to App"
  vpc_id      = var.vpc_id
  #tags        = var.tags
}

resource "aws_security_group" "app_sg" {
  description = "SSH ingress from Bastion and all TCP traffic ingress from ALB Security Group"
  vpc_id      = var.vpc_id
  #tags        = var.tags
}

resource "aws_security_group_rule" "out_http" {
  #set specific group rules for ports and ip addresses
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.general_sg.id
}

resource "aws_security_group_rule" "out_ssh_bastion" {
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion_sg.id
  source_security_group_id = aws_security_group.app_sg.id
}

resource "aws_security_group_rule" "out_http_app" {
  type              = "egress"
  description       = "Allow TCP internet traffic egress from app layer"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg.id
}

resource "aws_security_group_rule" "in_ssh_bastion_from_anywhere" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "in_ssh_app_from_bastion" {
  type                     = "ingress"
  description              = "Allow SSH from a Bastion Security Group"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "in_sql_from_bastion" {
  type                     = "ingress"
  description              = "Allow SQL from Bastion Security Group"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "in_sql_from_app" {
  type                     = "ingress"
  description              = "Allow SQL from app Security Group"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.app_sg.id
}
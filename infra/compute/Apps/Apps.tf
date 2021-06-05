resource "aws_instance" "app_instance" {
  ami           = "ami-0a3f5ff1cb905da33"
  instance_type = "t2.micro"
  key_name      = "lyit_key"
  count         = 2

  subnet_id              = var.prv_subnet_id
  vpc_security_group_ids = [var.security_group_general_sg_id, var.security_group_app_sg_id]

  #tags = var.tags
}
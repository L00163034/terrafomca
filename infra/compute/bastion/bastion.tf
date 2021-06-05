resource "aws_instance" "jump_box" {
  ami           = "ami-0a3f5ff1cb905da33"
  instance_type = "t2.micro"
  key_name      = "lyit_key"

  subnet_id              = var.pub_subnet_id
  vpc_security_group_ids = [var.security_group_general_sg_id, var.security_group_bastion_sg_id]

  #tags = var.tags
}
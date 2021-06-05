output "security_group_general_sg_id" {
  value = aws_security_group.general_sg.id
}
output "security_group_bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}
output "security_group_app_sg_id" {
  value = aws_security_group.app_sg.id
}
output "security_group_rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

module "vpc" {
  source             = "./infra/networking/vpc"
  IP_address_space   = var.IP_address_space
  Pub_Subnet         = var.Pub_Subnet
  Prv_Subnet         = var.Prv_Subnet
  DB_Subnet          = var.DB_Subnet
  Availability_Zone  = var.Availability_Zone
  Availability_ZoneB = var.Availability_ZoneB
}

module "vpc-routes" {
  source         = "./infra/networking/vpc-routes"
  depends_on     = [module.vpc]
  vpc_id         = module.vpc.vpc_id
  gateway_id     = module.vpc.gateway_id
  pub_subnet_id  = module.vpc.pub_subnet_id
  nat_gateway_id = module.vpc.nat_gateway_id
  prv_subnet_id  = module.vpc.prv_subnet_id
  db_subnet_id   = module.vpc.db_subnet_id
}

module "vpc-security" {
  source     = "./infra/networking/security"
  depends_on = [module.vpc]
  vpc_id     = module.vpc.vpc_id

}

module "key_gen" {
  source = "./infra/compute/keys"

}

module "Bastion" {
  source                       = "./infra/compute/Bastion"
  depends_on                   = [module.vpc]
  pub_subnet_id                = module.vpc.pub_subnet_id
  security_group_general_sg_id = module.vpc-security.security_group_general_sg_id
  security_group_bastion_sg_id = module.vpc-security.security_group_bastion_sg_id

}

module "Apps" {
  source                       = "./infra/compute/Apps"
  depends_on                   = [module.vpc]
  prv_subnet_id                = module.vpc.prv_subnet_id
  security_group_general_sg_id = module.vpc-security.security_group_general_sg_id
  security_group_app_sg_id     = module.vpc-security.security_group_app_sg_id
}

module "DataBase" {
  source                   = "./infra/DataBase"
  depends_on               = [module.vpc]
  security_group_rds_sg_id = module.vpc-security.security_group_rds_sg_id
  allocated_storage        = var.allocated_storage
  db_engine                = var.db_engine
  engine_version           = var.engine_version
  instance_class           = var.instance_class
  DBName                   = var.DBName
  db_username              = var.db_username
  db_subnet_id             = module.vpc.db_subnet_id
  prv_subnet_id            = module.vpc.prv_subnet_id
  db_subnet_group_name     = var.db_subnet_group_name
}
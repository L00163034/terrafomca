variable "AccessKeyId" {
  default = "youraccesskey"
}

variable "SecretAccessKey" {
  default = "YourSecretAccessKey"
}

variable "Region" {
  default = "eu-west-1"
}

variable "IP_address_space" {
  type    = string
  default = "10.88.0.0/16"
}

variable "Prv_Subnet" {
  type    = string
  default = "10.88.1.0/24"
}

variable "Pub_Subnet" {
  type    = string
  default = "10.88.0.0/24"
}

variable "DB_Subnet" {
  type    = string
  default = "10.88.2.0/24"
}

variable "Availability_Zone" {
  description = "Availability Zone"
  type        = string
  default     = "eu-west-1a"
}

variable "Availability_ZoneB" {
  description = "Availability Zone"
  type        = string
  default     = "eu-west-1b"
}

variable "allocated_storage" {
  default = "10"
}

variable "db_engine" {
  default = "mariadb"
}

variable "engine_version" {
  default = "10.3"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "DBName" {
  default = "l00163034db"
}

variable "db_username" {
  default = "sa4sql"
}

variable "db_subnet_group_name" {
  default = "mariadb_snet_gp_name"
}

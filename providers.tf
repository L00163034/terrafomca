terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile    = "default"
  region     = var.Region
  access_key = var.AccessKeyId
  secret_key = var.SecretAccessKey
  # remember that if you change the region you will also need to change the ami 
}
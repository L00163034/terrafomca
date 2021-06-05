terraform {
  backend "s3" {
    bucket = "l00163034-terraform-store"
    key    = "tfstate"
    region = "eu-west-1"
  }
}
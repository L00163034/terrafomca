terraform {
  backend "s3" {
    bucket = var.bucketName
    key    = "tfstate"
    region = "eu-west-1"
  }
}

terraform {
  backend "s3" {
    bucket = "YourBucketName"
    key    = "tfstate"
    region = "eu-west-1"
  }
}

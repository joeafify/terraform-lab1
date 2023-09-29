terraform {
  backend "s3" {
    bucket  = "terraform-bucket-505"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    # dynamodb_table = "terraform-tfstate-locking"
    profile = "terraform"
  }
}
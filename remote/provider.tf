terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  backend "s3" {
    bucket   = "daws-81s-remotestate"
    key      = "remote-state-demo"
    region   = "us-east-1"
    dynamodb_table = "dawws-81s-locking"
  }
}

provider "aws" {
  region = "us-east-1"
}

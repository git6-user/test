terraform {
  required_version = "~>1.0"
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket         = "backend-1s1-init"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-table"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}


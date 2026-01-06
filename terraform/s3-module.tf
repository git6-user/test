module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "backend-1s1-init"
  acl    = "private"
  force_destroy = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name     = "my-table"
  hash_key = "LockID"
  deletion_protection_enabled = var.prevent_destroy


  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
  
}





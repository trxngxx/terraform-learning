terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "path/to/statefile"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

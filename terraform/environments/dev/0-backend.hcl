terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "path/to/statefile"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

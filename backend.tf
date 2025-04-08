terraform {
  backend "s3" {
    bucket       = "lab3-terraform-badry2025"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

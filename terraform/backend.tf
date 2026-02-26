terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }


  # Configure backend values with -backend-config, for example:
  # terraform init -backend-config=backend.dev.hcl
  backend "s3" {}
}

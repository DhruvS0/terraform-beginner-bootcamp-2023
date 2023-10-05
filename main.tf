terraform {
  cloud {
    organization = "dhruvshah_dms"

    workspaces {
      name = "terra-house-1"
    }
  }
    required_providers {
      random = {
        source = "hashicorp/random"
        version = "3.5.1"
      }
  
      aws = {
        source = "hashicorp/aws"
        version = "5.19.0"
      }
    }
}

provider "random" {
    # configuration options
}

provider "aws" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  lower            = true
  upper            = false
  length           = 16
  special          = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
}
output "random_bucket_name" {
    value = random_string.bucket_name.result
}
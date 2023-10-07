terraform {
  # cloud {
  #   organization = "dhruvshah_dms"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
    required_providers {
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

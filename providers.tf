terraform {
  # cloud {
  #   organization = "dhruvshah_dms"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
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

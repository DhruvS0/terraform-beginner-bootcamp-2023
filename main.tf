terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  # cloud {
  #   organization = "dhruvshah_dms"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid 
  token= var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "How to play Valorant in 2023!"
  description = <<DESCRIPTION
Valorant is a tactical first-person shooter by Riot Games. It's available on PC. 
Engage in strategic battles, choose unique Agents, and coordinate with your team. 
Master shooting mechanics and use Agent abilities. Stay updated with patches for evolving gameplay.
Enjoy the competitive experience!
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
# domain_name = "2fdq3gz.cloudfront.net"
  town = "missingo"
  content_version = 1
}


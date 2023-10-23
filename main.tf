terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "dhruvshah_dms"

    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid 
  token= var.terratowns_access_token
}

module "home_valorant_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.valorant.public_path
  content_version = var.valorant.content_version
}

resource "terratowns_home" "home" {
  name = "How to play Valorant in 2023!"
  description = <<DESCRIPTION
Valorant is a tactical first-person shooter by Riot Games. It's available on PC. 
Engage in strategic battles, choose unique Agents, and coordinate with your team. 
Master shooting mechanics and use Agent abilities. Stay updated with patches for evolving gameplay.
Enjoy the competitive experience!
DESCRIPTION
  domain_name = module.home_valorant_hosting.domain_name
  town = "missingo"
  content_version = var.valorant.content_version
}

module "home_kedarkanta_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.kedarkanta.public_path
  content_version = var.kedarkanta.content_version
}

resource "terratowns_home" "home1" {
  name = "Kedarkanta Trek - Topmost trek of Uttarakhand Himalayas!"
  description = <<DESCRIPTION
Kedarkanta Trek is a thrilling high-altitude adventure in the heart of the Indian Himalayas. 
Set out on a breathtaking journey through snow-capped peaks and pristine wilderness. 
Trek with experienced guides, immerse in local culture, and camp under the starlit sky. 
Master trekking techniques and acclimatize to changing altitudes. Stay tuned for weather updates and safety precautions.
Experience the natural beauty and serenity of Kedarkanta Trek!
DESCRIPTION
  domain_name = module.home_kedarkanta_hosting.domain_name
  town = "the-nomad-pad"
  content_version = var.kedarkanta.content_version
}
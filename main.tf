terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.95.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-terraform-test"
    storage_account_name = "samkterraformtest"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_container_group" "CG-terraform-test" {
  name                = "CG-weather-api"
  location            = "westeurope"
  resource_group_name = "RG-terraform-test"

  ip_address_type = "public"
  dns_name_label  = "mktestweatherapi"
  os_type         = "Linux"

  container {
    name   = "weatherapi"
    image  = "mktje/weatherapi"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}


#terraform commands

#init
#plan
#apply
#destroy
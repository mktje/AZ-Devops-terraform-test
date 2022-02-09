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

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}


resource "azurerm_container_group" "CG-terraform-test" {
  name                = "weatherapp"
  location            = "westeurope"
  resource_group_name = "RG-terraform-test"

  ip_address_type = "public"
  dns_name_label  = "mktestweatherapi"
  os_type         = "Linux"

  container {
    name   = "weatherapp"
    image  = "mktje/weatherapp:${var.imagebuild}"
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
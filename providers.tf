provider "azurerm" {
  version = ">=1.30.0"
}

provider "azuread" {
  version = ">=0.4.0"
}


terraform {
  #  backend "azurerm" {  #    storage_account_name = "infra4711"  #    container_name       = "tfstate"  #    key                  = "web4711.terraform.tfstate"  #  }
}

data "azurerm_client_config" "current" {}

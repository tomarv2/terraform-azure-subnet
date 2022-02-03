terraform {
  required_version = ">= 1.0.1"
  required_providers {
    azurerm = {
      version = ">= 2.90"
    }
  }
}

provider "azurerm" {
  features {}
}

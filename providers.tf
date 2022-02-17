terraform {
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
    }
    aws = {
      source = "hashicorp/aws"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  #backend "remote" {}
}

provider "azurerm" {
  features {}
}
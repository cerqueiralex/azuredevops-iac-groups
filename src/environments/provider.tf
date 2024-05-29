terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.101.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "0.10.0"
    }
  }
}

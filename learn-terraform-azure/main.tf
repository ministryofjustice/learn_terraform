# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {# Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
#  version = "=1.44.0"
  features {}
}
# Configure the Microsoft Azure Active Directory Provider provider "azuread" { version = "=0.7.0" }

data "azuread_user" "example" {
  user_principal_name = "TempTestUser2@nomsdigitechoutlook.onmicrosoft.com"
}

resource "azuread_group" "example" {
  name = "PoC-Evaluation-Sandpit-TempTestGroupWithMember"
}

resource "azuread_group_member" "example" {
  group_object_id   = azuread_group.example.id
  member_object_id  = data.azuread_user.example.id
lifecycle {
    create_before_destroy = true
  }
} 

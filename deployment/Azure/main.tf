# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create Main resourses
# resourse Group
resource "azurerm_resource_group" "halangroup" {
  name = "halangroup"
  location = "West Europe"
}
# Networking
# Main Virtual Network
resource "azurerm_virtual_network" "halannetwork" {
  name = "halannetwork"
  location = azurerm_resource_group.halangroup.location
  resource_group_name = azurerm_resource_group.halangroup.name
  address_space = [ "10.0.0.0/16" ]
}

# Main Virtual Subnet
resource "azurerm_subnet" "halansubnet" {
  name = "sub1"
  resource_group_name = azurerm_resource_group.halangroup.name
  virtual_network_name = azurerm_virtual_network.halannetwork.name
  address_prefixes = [ "10.0.0.0/24" ]
}

##########################################################


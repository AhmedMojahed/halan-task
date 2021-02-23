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
  name     = "halangroup"
  location = "West Europe"
}
# Networking
# Main Virtual Network
resource "azurerm_virtual_network" "halannetwork" {
  name                = "halannetwork"
  location            = azurerm_resource_group.halangroup.location
  resource_group_name = azurerm_resource_group.halangroup.name
  address_space       = ["10.0.0.0/16"]
}

# Main Virtual Subnet
resource "azurerm_subnet" "halansubnet" {
  name                 = "sub1"
  resource_group_name  = azurerm_resource_group.halangroup.name
  virtual_network_name = azurerm_virtual_network.halannetwork.name
  address_prefixes     = ["10.0.0.0/24"]
}

##########################################################

### VMs Resources ###

## App Vm ##

# App VM public Ip
resource "azurerm_public_ip" "halanappvmpubip" {
  name                = "halan-app-vm-pubip"
  location            = azurerm_resource_group.halangroup.location
  resource_group_name = azurerm_resource_group.halangroup.name
  allocation_method   = "Dynamic"
}

# App VM Nic
resource "azurerm_network_interface" "halanappvmnic" {
  name                = "halan-app-vm-nic"
  location            = azurerm_resource_group.halangroup.location
  resource_group_name = azurerm_resource_group.halangroup.name

  ip_configuration {
    name                          = "halan-app-vm-nic-configuration"
    subnet_id                     = azurerm_subnet.halansubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.10"
    public_ip_address_id          = azurerm_public_ip.halanappvmpubip.id
  }

}

# APP VM Linux
resource "azurerm_linux_virtual_machine" "halanappvm" {
  name                            = "halan-app-vm"
  location                        = azurerm_resource_group.halangroup.location
  resource_group_name             = azurerm_resource_group.halangroup.name
  network_interface_ids           = [azurerm_network_interface.halanappvmnic.id]
  size                            = "Standard_A1_V2"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = "~/.ssh/id_rsa.pub"
  }

  os_disk {
    name                 = "halan-app-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}


## DBMaster Vm ##

# DBMaster VM public Ip
resource "azurerm_public_ip" "halandbmvmpubip" {
  name                = "halan-dbm-vm-pubip"
  location            = azurerm_resource_group.halangroup.location
  resource_group_name = azurerm_resource_group.halangroup.name
  allocation_method   = "Dynamic"
}

# dbm VM Nic
resource "azurerm_network_interface" "halandbmvmnic" {
  name                = "halan-dbm-vm-nic"
  location            = azurerm_resource_group.halangroup.location
  resource_group_name = azurerm_resource_group.halangroup.name

  ip_configuration {
    name                          = "halan-dbm-vm-nic-configuration"
    subnet_id                     = azurerm_subnet.halansubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.11"
    public_ip_address_id          = azurerm_public_ip.halandbmvmpubip.id
  }

}

# dbm VM Linux
resource "azurerm_linux_virtual_machine" "halandbmvm" {
  name                            = "halan-dbm-vm"
  location                        = azurerm_resource_group.halangroup.location
  resource_group_name             = azurerm_resource_group.halangroup.name
  network_interface_ids           = [azurerm_network_interface.halandbmvmnic.id]
  size                            = "Standard_A1_V2"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = "~/.ssh/id_rsa.pub"
  }

  os_disk {
    name                 = "halan-dbm-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}



## dbs Vm ##

# dbs VM public Ip
resource "azurerm_public_ip" "halandbsvmpubip" {
  name                = "halan-dbs-vm-pubip"
  location            = azurerm_resource_group.halangroup.location
  resource_group_name = azurerm_resource_group.halangroup.name
  allocation_method   = "Dynamic"
}

# dbs VM Nic
resource "azurerm_network_interface" "halandbsvmnic" {
  name                = "halan-dbs-vm-nic"
  location            = azurerm_resource_group.halangroup.location
  resource_group_name = azurerm_resource_group.halangroup.name

  ip_configuration {
    name                          = "halan-dbs-vm-nic-configuration"
    subnet_id                     = azurerm_subnet.halansubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.12"
    public_ip_address_id          = azurerm_public_ip.halandbsvmpubip.id
  }

}

# dbs VM Linux
resource "azurerm_linux_virtual_machine" "halandbsvm" {
  name                            = "halan-dbs-vm"
  location                        = azurerm_resource_group.halangroup.location
  resource_group_name             = azurerm_resource_group.halangroup.name
  network_interface_ids           = [azurerm_network_interface.halandbsvmnic.id]
  size                            = "Standard_A1_V2"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = "~/.ssh/id_rsa.pub"
  }

  os_disk {
    name                 = "halan-dbs-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
}


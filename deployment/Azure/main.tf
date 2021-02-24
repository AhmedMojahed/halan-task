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
  name     =   var.resource_group
  location =  var.location
}
# Networking
# Main Virtual Network
resource "azurerm_virtual_network" "halannetwork" {
  name                = var.virtual_network
  location            = var.location
  resource_group_name = azurerm_resource_group.halangroup.name
  address_space       = [var.address_space]
}

# Main Virtual Subnet
resource "azurerm_subnet" "halansubnet" {
  name                 = "${var.virtual_network}-sub1"
  resource_group_name  = azurerm_resource_group.halangroup.name
  virtual_network_name = azurerm_virtual_network.halannetwork.name
  address_prefixes     = [var.address_prefixes]
}

##########################################################

### VMs Resources ###

## App Vm ##

# App VM public Ip
resource "azurerm_public_ip" "halanappvmpubip" {
  name                = "${var.app_vm_name}-pubip"
  location            = var.location
  resource_group_name = azurerm_resource_group.halangroup.name
  allocation_method   = "Dynamic"
}

# App VM Nic
resource "azurerm_network_interface" "halanappvmnic" {
  name                = "${var.app_vm_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.halangroup.name

  ip_configuration {
    name                          = "${var.app_vm_name}-nic-configuration"
    subnet_id                     = azurerm_subnet.halansubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.app_vm_private_ip
    public_ip_address_id          = azurerm_public_ip.halanappvmpubip.id
  }

}

# APP VM Linux
resource "azurerm_linux_virtual_machine" "halanappvm" {
  name                            = var.app_vm_name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.halangroup.name
  network_interface_ids           = [azurerm_network_interface.halanappvmnic.id]
  size                            = var.vm_size
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = "~/.ssh/id_rsa.pub"
  }

  os_disk {
    name                 = "${var.app_vm_name}-os-disk"
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

##########################################################

## DBMaster Vm ##

# DBMaster VM public Ip
resource "azurerm_public_ip" "halandbmvmpubip" {
  name                = "${var.dbm_vm_name}-pubip"
  location            = var.location
  resource_group_name = azurerm_resource_group.halangroup.name
  allocation_method   = "Dynamic"
}

# dbm VM Nic
resource "azurerm_network_interface" "halandbmvmnic" {
  name                = "${var.dbm_vm_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.halangroup.name

  ip_configuration {
    name                          = "${var.dbm_vm_name}-nic-configuration"
    subnet_id                     = azurerm_subnet.halansubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.dbm_vm_private_ip
    public_ip_address_id          = azurerm_public_ip.halandbmvmpubip.id
  }

}

# dbm VM Linux
resource "azurerm_linux_virtual_machine" "halandbmvm" {
  name                            = "${var.dbm_vm_name}"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.halangroup.name
  network_interface_ids           = [azurerm_network_interface.halandbmvmnic.id]
  size                            = var.vm_size
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = "~/.ssh/id_rsa.pub"
  }

  os_disk {
    name                 = "${var.dbm_vm_name}-os-disk"
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


##########################################################

## dbs Vm ##

# dbs VM public Ip
resource "azurerm_public_ip" "halandbsvmpubip" {
  name                = "${var.dbs_vm_name}-pubip"
  location            = var.location
  resource_group_name = azurerm_resource_group.halangroup.name
  allocation_method   = "Dynamic"
}

# dbs VM Nic
resource "azurerm_network_interface" "halandbsvmnic" {
  name                = "${var.dbs_vm_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.halangroup.name

  ip_configuration {
    name                          = "${var.dbs_vm_name}-nic-configuration"
    subnet_id                     = azurerm_subnet.halansubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.dbs_vm_private_ip
    public_ip_address_id          = azurerm_public_ip.halandbsvmpubip.id
  }

}

# dbs VM Linux
resource "azurerm_linux_virtual_machine" "halandbsvm" {
  name                            = "${var.dbs_vm_name}"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.halangroup.name
  network_interface_ids           = [azurerm_network_interface.halandbsvmnic.id]
  size                            = var.vm_size
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = "~/.ssh/id_rsa.pub"
  }

  os_disk {
    name                 = "${var.dbs_vm_name}-os-disk"
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


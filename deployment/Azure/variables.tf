### Main resources Variables ###

variable "resource_group" {
  description = "the name of the resource group"
  default     = "halan-group"
}

variable "location" {
  description = "the location of the resource group"
  default     = "West Europe"
}

variable "virtual_network" {
  description = "the name of the main virtual network"
  default     = "halan-network"
}

variable "vn_address_space" {
  description = "the address_space (range) of the main virtual network"
  default     = "10.0.0.0/16"
}

variable "vn_sub1_address_prefixes" {
  description = "the address prefixes of the main virtual network subnet 1"
  default     = "10.0.0.0/24"
}


####################################################

### VMs Resources ###

variable "vm_size" {
  description = "the private ip address of the App virtual machine"
  default     = "Standard_A1_V2"
}

## App Vm ##

variable "app_vm_name" {
  description = "the name of the App virtual machine"
  default     = "halan-app-vm"
}

variable "app_vm_private_ip" {
  description = "the private ip address of the App virtual machine"
  default     = "10.0.0.10"
}

####################################################

## dbm Vm ##

variable "dbm_vm_name" {
  description = "the name of the dbm virtual machine"
  default     = "halan-dbm-vm"
}

variable "dbm_vm_private_ip" {
  description = "the private ip address of the dbm virtual machine"
  default     = "10.0.0.11"
}

####################################################
## dbs Vm ##

variable "dbs_vm_name" {
  description = "the name of the dbs virtual machine"
  default     = "halan-dbs-vm"
}

variable "dbs_vm_private_ip" {
  description = "the private ip address of the dbs virtual machine"
  default     = "10.0.0.12"
}

####################################################

variable "name" {
  description = "The name of the VM."
  type        = string
}

variable "vm_size" {
  description = "The size of the VM."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the VM."
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VM."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to place the VM in."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}

variable "os_type" {
  description = "The OS type of the VM (windows or linux)."
  type        = string
}

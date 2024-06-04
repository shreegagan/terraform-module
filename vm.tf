resource "azurerm_network_interface" "nic" {
  name                = "${var.name}_nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = var.name
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${var.name}_os_disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  dynamic "storage_image_reference" {
    for_each = var.os_type == "windows" ? [1] : []
    content {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    }
  }

  dynamic "storage_image_reference" {
    for_each = var.os_type == "linux" ? [1] : []
    content {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
  }

  os_profile {
    computer_name  = var.name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  dynamic "os_profile_linux_config" {
    for_each = var.os_type == "linux" ? [1] : []
    content {
      disable_password_authentication = false
    }
  }

  dynamic "os_profile_windows_config" {
    for_each = var.os_type == "windows" ? [1] : []
    content {}
  }
}







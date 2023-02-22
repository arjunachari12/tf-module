resource "azurerm_network_interface" "webinterface" {
  name                = "webinterface"
  location            = local.location  
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.networking_module.subnets["web-subnet"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.webip.id
  }

  depends_on = [
    module.networking_module.virtual_network,
    azurerm_public_ip.webip
  ]
}

resource "azurerm_public_ip" "webip" {
  name                = "web-ip"
  resource_group_name = local.resource_group_name
  location            = local.location 
  allocation_method   = "Static"
}

resource "azurerm_windows_virtual_machine" "webvm" {
  
  name                = "webvm"
  resource_group_name = local.resource_group_name
  location            = local.location 
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  admin_password      = "Azure@123"
   network_interface_ids = [azurerm_network_interface.webinterface.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.webinterface,
    module.general_module.resourcegroup
  ]
}
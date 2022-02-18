# ---------------------------------------------------------------------------------------------------------------------
# Azure Bastion
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_resource_group" "bastion_rg" {
  name     = "rg-bastion"
  location = var.azure_region
}

resource "azurerm_virtual_network" "bastion_vnet" {
  name                = "BastionVNet"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  address_space       = [cidrsubnet(var.azure_supernet, 7, 127)]
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.bastion_rg.name
  virtual_network_name = azurerm_virtual_network.bastion_vnet.name
  address_prefixes     = [cidrsubnet(var.azure_supernet, 8, 254)]
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = "bastion-pip"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = "BastionHost"
  resource_group_name = azurerm_resource_group.bastion_rg.name
  location            = azurerm_resource_group.bastion_rg.location

  ip_configuration {
    name                 = "bastion-pip"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

resource "aviatrix_azure_peer" "bastion_azure_spoke_1_peering" {
  account_name1             = var.azure_account
  account_name2             = var.azure_account
  vnet_name_resource_group1 = "${azurerm_virtual_network.bastion_vnet.name}:${azurerm_virtual_network.bastion_vnet.resource_group_name}:${azurerm_virtual_network.bastion_vnet.guid}"
  vnet_name_resource_group2 = module.azure_spoke_1.spoke_gateway.vpc_id
  vnet_reg1                 = var.azure_region
  vnet_reg2                 = var.azure_region

  depends_on = [module.azure_spoke_1]
}
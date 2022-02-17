# ---------------------------------------------------------------------------------------------------------------------
# Azure Spoke
# ---------------------------------------------------------------------------------------------------------------------
module "prod_app" {
  source        = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  cloud         = "azure"
  name          = "prod-app"
  cidr          = cidrsubnet(var.azure_supernet, 8, 211)
  region        = var.azure_region
  account       = var.azure_account
  transit_gw    = module.azure_transit_1.transit_gateway.gw_name
  insane_mode   = var.hpe
  instance_size = var.azure_instance_size
  ha_gw         = var.ha_gw

  depends_on = [module.azure_transit_1]
}

# ---------------------------------------------------------------------------------------------------------------------
# Azure VM
# ---------------------------------------------------------------------------------------------------------------------
module "prod_app_vm" {
  source              = "Azure/compute/azurerm"
  resource_group_name = module.prod_app.vpc.resource_group
  is_windows_image    = true
  vm_hostname         = "prod-app-vm" // line can be removed if only one VM module per resource group
  admin_password      = var.vm_admin_password
  vm_os_simple        = "WindowsServer"
  nb_public_ip        = 0 # do not assign public IP, set to 1 to assign public IP
  vnet_subnet_id      = module.prod_app.vpc.private_subnets[0].subnet_id
  vm_size             = "Standard_B1ms"
}

resource "azurerm_virtual_machine_extension" "disable_fw" {
  name                 = "disable-win-fw"
  virtual_machine_id   = module.prod_app_vm.vm_ids[0]
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {
     "commandToExecute": "powershell -encodedCommand ${textencodebase64(file("disable-win-fw.ps1"), "UTF-16LE")}"
  }
  SETTINGS
}

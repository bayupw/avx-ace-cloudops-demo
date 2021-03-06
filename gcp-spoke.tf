# ---------------------------------------------------------------------------------------------------------------------
# GCP Spoke
# ---------------------------------------------------------------------------------------------------------------------
module "gcp_spoke_1" {
  source = "terraform-aviatrix-modules/mc-spoke/aviatrix"

  cloud         = "gcp"
  name          = "gcp-spoke-1"
  cidr          = cidrsubnet(var.gcp_supernet, 8, 211)
  region        = var.gcp_region
  account       = var.gcp_account
  transit_gw    = module.gcp_transit_1.transit_gateway.gw_name
  insane_mode   = var.hpe
  instance_size = var.gcp_instance_size
  ha_gw         = var.ha_gw

  depends_on = [module.gcp_transit_1]
}
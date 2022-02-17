# ---------------------------------------------------------------------------------------------------------------------
# AWS Transit
# ---------------------------------------------------------------------------------------------------------------------
module "aws_transit_1" {
  source = "terraform-aviatrix-modules/mc-transit/aviatrix"

  cloud               = "aws"
  name                = "aws-transit"
  region              = var.aws_region
  cidr                = cidrsubnet(var.aws_supernet, 7, 100)
  account             = var.aws_account
  insane_mode         = var.hpe
  instance_size       = var.aws_instance_size
  ha_gw               = var.ha_gw
  enable_segmentation = var.enable_segmentation
}

# ---------------------------------------------------------------------------------------------------------------------
# Azure Transit
# ---------------------------------------------------------------------------------------------------------------------
module "azure_transit_1" {
  source              = "terraform-aviatrix-modules/mc-transit/aviatrix"
  cloud               = "azure"
  name                = "azure-transit"
  region              = var.azure_region
  cidr                = cidrsubnet(var.azure_supernet, 7, 100)
  account             = var.azure_account
  insane_mode         = var.hpe
  instance_size       = var.azure_instance_size
  ha_gw               = var.ha_gw
  enable_segmentation = var.enable_segmentation
}

# ---------------------------------------------------------------------------------------------------------------------
# GCP Transit
# ---------------------------------------------------------------------------------------------------------------------
module "gcp_transit_1" {
  source = "terraform-aviatrix-modules/mc-transit/aviatrix"

  cloud               = "gcp"
  name                = "gcp-transit"
  region              = var.gcp_region
  cidr                = cidrsubnet(var.gcp_supernet, 7, 100)
  account             = var.gcp_account
  insane_mode         = var.hpe
  instance_size       = var.gcp_instance_size
  ha_gw               = var.ha_gw
  enable_segmentation = var.enable_segmentation
}
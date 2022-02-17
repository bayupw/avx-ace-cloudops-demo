# ---------------------------------------------------------------------------------------------------------------------
# CIDR
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_supernet" {
  type    = string
  default = "10.1.0.0/16"
}

variable "azure_supernet" {
  type    = string
  default = "192.168.0.0/16"
}

variable "gcp_supernet" {
  type    = string
  default = "172.16.0.0/16"
}

# ---------------------------------------------------------------------------------------------------------------------
# CSP Accounts
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_account" {
  type        = string
  description = "AWS access account"
}

variable "azure_account" {
  type        = string
  description = "Azure access account"
}

variable "gcp_account" {
  type        = string
  description = "GCP access account"
}

# ---------------------------------------------------------------------------------------------------------------------
# CSP Regions
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_region" {
  type        = string
  default     = "ap-southeast-2"
  description = "AWS region"
}

variable "azure_region" {
  type        = string
  default     = "Australia East"
  description = "Azure region"
}

variable "gcp_region" {
  type        = string
  default     = "australia-southeast1"
  description = "GCP region"
}

# ---------------------------------------------------------------------------------------------------------------------
# Aviatrix Transit & Spoke Gateway Size
# ---------------------------------------------------------------------------------------------------------------------
variable "aws_instance_size" {
  type        = string
  default     = "t2.micro" #hpe "c5.xlarge"
  description = "AWS gateway instance size"
}

variable "azure_instance_size" {
  type        = string
  default     = "Standard_B1ms" #hpe "Standard_D3_v2"
  description = "Azure gateway instance size"
}

variable "gcp_instance_size" {
  type        = string
  default     = "n1-standard-1" #hpe "n1-highcpu-4"
  description = "GCP gateway instance size"
}

# ---------------------------------------------------------------------------------------------------------------------
# Aviatrix Gateway Options
# ---------------------------------------------------------------------------------------------------------------------
variable "hpe" {
  type        = bool
  default     = false
  description = "Insane mode"
}

variable "ha_gw" {
  type        = bool
  default     = true
  description = "Enable HA gateway"
}

variable "enable_segmentation" {
  type        = bool
  default     = false
  description = "Enable segmentation"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS SSM Options
# ---------------------------------------------------------------------------------------------------------------------
variable "ssm_instance_profile" {
  type        = string
  default     = "ssm-instance-profile"
  description = "IAM Instance Profile for SSM"
}

variable "vm_admin_password" {
  type        = string
  default     = "Aviatrix123#"
  description = "VM admin password"
}

# ---------------------------------------------------------------------------------------------------------------------
# Azure Bastion Options
# ---------------------------------------------------------------------------------------------------------------------
variable "bastion_vnet" {
  type        = string
  default     = "ManagementVNet"
  description = "Bastion VNet name"
}

variable "bastion_rg" {
  type        = string
  default     = "ManagementServices"
  description = "Bastion VNet Resource Group name"
}
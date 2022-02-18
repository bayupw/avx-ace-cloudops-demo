# Aviatrix ACE Cloud Operations Demo

Terraform codes to setup single region Aviatrix Multi-Cloud Networking Architecture using Aviatrix modules across AWS, Azure and GCP.
Create an Amazon Linux test EC2 instance in AWS with SSM, allow inbound from RFC1918.
Create a Windows test VM with Firewall disabled in Azure with Bastion, allow inbound from RFC1918.

![Aviatrix ACE Cloud Operations Demo Topology](images/avx-ace-cloudops-demo.png "Aviatrix ACE Cloud Operations Demo Topology")

## Environment Variables

To run this project, you will need to set the following environment variables

Variables | Description
--- | ---
AVIATRIX_CONTROLLER_IP | Aviatrix Controller IP or FQDN 
AVIATRIX_USERNAME | Aviatrix Controller Username
AVIATRIX_PASSWORD | Aviatrix Controller Password
TF_VAR_aws_account | AWS Aviatrix Account 
TF_VAR_azure_account | Azure Aviatrix Account
TF_VAR_gcp_account | GCP Aviatrix Account
AWS_ACCESS_KEY_ID | AWS Access Key
AWS_SECRET_ACCESS_KEY | AWS Secret Access Key
AWS_DEFAULT_REGION | AWS Default Region
ARM_SUBSCRIPTION_ID | Azure Subscription ID
ARM_TENANT_ID | Azure Tenant ID
ARM_CLIENT_ID | Azure Client ID
ARM_CLIENT_SECRET | Azure Client Secret

## Run Locally

Clone the project

```bash
git clone https://github.com/bayupw/avx-ace-cloudops-demo.git
```

Go to the project directory

```bash
cd avx-ace-cloudops-demo
```

Set environment variables

```bash
export AVIATRIX_CONTROLLER_IP="aviatrixcontroller.aviatrix.lab"
export AVIATRIX_USERNAME="admin"
export AVIATRIX_PASSWORD="aviatrix123"
export TF_VAR_aws_account="AWS-Aviatrix-Account"
export TF_VAR_azure_account="Azure-Aviatrix-Account"
export TF_VAR_gcp_account="GCP-Aviatrix-Account"
export AWS_ACCESS_KEY_ID="A1b2C3d4E5"
export AWS_SECRET_ACCESS_KEY="A1b2C3d4E5"
export AWS_DEFAULT_REGION="ap-southeast-2"
export ARM_SUBSCRIPTION_ID="aaaa-1111-bbbb-2222-cccc-3333"
export ARM_TENANT_ID="aaaa-1111-bbbb-2222-cccc-3333"
export ARM_CLIENT_ID="aaaa-1111-bbbb-2222-cccc-3333"
export ARM_CLIENT_SECRET="A1b2C3d4E5"
```

Terraform workflow

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|----------|
| aws_supernet | CIDR for the overall supernet | `10.1.0.0/16` | no |
| azure_supernet | CIDR for the overall supernet | `192.168.0.0/16` | no |
| gcp_supernet | CIDR for the overall supernet | `172.16.0.0/16` | no |
| aws_account | AWS Account for Aviatrix Controller | `null` | yes |
| azure_account | Azure Account for Aviatrix Controller | `null` | yes |
| gcp_account | GCP Account for Aviatrix Controller | `null` | yes |
| aws_region | AWS Region | `ap-southeast-2` | no |
| azure_region | Azure Region | `Australia East` | no |
| gcp_region | GCP Region | `australia-southeast1` | no |
| aws_instance_size | AWS gateway instance size | `t2.micro` | no |
| azure_instance_size | Azure gateway instance size | `Standard_B1ms` | no |
| gcp_instance_size | GCP gateway instance size | `n1-standard-1` | no |
| hpe | Insane mode flag | `false` | no |
| ha_gw | Enable HA gateway | `true` | no |
| enable_segmentation | Enable segmentation | `false` | no |
| vm_admin_password | AWS EC2 & Azure VM password | `Aviatrix123#` | no |
| bastion_vnet | Bastion VNet name | `ManagementVNet` | no |
| bastion_rg | Bastion VNet Resource Group name | `ManagementServices` | no |
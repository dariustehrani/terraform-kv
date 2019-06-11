# Azure Terraform Module for a Virtual Machine Scaleset

## Example usage
`````
project_name = "4711"
resource_group_name = "4711"
location = "westeurope"
tags = "your tags"

# network settings
subnet_id = "subnetid123"

# VM Settings
vm_sku = "Standard_B2s"
capacity = "2"

# IAM
admin_user = "4711"
path_to_ssh_pubkey = ""

# Application Port to be exposed. 
application_port = "80"
````
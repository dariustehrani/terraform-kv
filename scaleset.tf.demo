module "web_scaleset" {
# where to load the module from, e.g. local path or git path
  source                = "./scaleset/"
  project_name          = "${var.project_name}"
  resource_group_name   = "${var.resource_group_name}"
  location              = "${var.location}" 
  tags                  = "${var.tags}"

# network settings
subnet_id = "${azurerm_subnet.infra.id}"

# VM Settings
vm_sku = "Standard_B2s"
capacity = "2"

# IAM
admin_user = "4711"
path_to_ssh_pubkey = "~/.ssh/4711.pub"

# Application Port to be exposed. 
application_port = "80"

}

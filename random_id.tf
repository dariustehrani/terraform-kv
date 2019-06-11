resource "random_id" "project-id" {
  keepers = {
    # Generate a new id each time we switch to a new resource group
    group_name = "${azurerm_resource_group.infra.name}"
  }

  byte_length = 4
}
resource "azurerm_resource_group" "infra" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_virtual_network" "infra" {
  name                = "${var.project_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.infra.name}"

  tags = "${var.tags}"
}

resource "azurerm_subnet" "infra" {
  name                 = "${var.project_name}-subnet"
  resource_group_name  = "${azurerm_resource_group.infra.name}"
  virtual_network_name = "${azurerm_virtual_network.infra.name}"
  address_prefix       = "10.0.2.0/24"
  service_endpoints    = ["Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB", "Microsoft.KeyVault", "Microsoft.Storage"]

}

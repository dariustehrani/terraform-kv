resource "azurerm_key_vault" "kv" {
  name                = "${var.project_name}-kv"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.infra.name}"
  tenant_id           = "${data.azurerm_client_config.current.tenant_id}"

  enabled_for_disk_encryption = true

  sku {
    name = "standard"
  }

  network_acls {
    virtual_network_subnet_ids = ["${azurerm_subnet.infra.id}"]
    default_action             = "Deny"
    bypass                     = "AzureServices"
  }

  tags = "${var.tags}"
}

resource "azuread_application" "kv-app" {
  name                       = "${var.project_name}-kv-app"
  homepage                   = "https://${var.project_name}"
  identifier_uris            = ["https://${var.project_name}"]
  reply_urls                 = ["https://${var.project_name}"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

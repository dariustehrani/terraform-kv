resource "azurerm_key_vault" "kv" {
  name                = "${var.project_name}-${random_id.project-id.hex}-kv"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.infra.name}"
  tenant_id           = "${data.azurerm_client_config.current.tenant_id}"

  enabled_for_disk_encryption = true

  sku {
    name = "standard"
  }

  tags = "${var.tags}"
}

resource "azuread_application" "kv-app" {
  name                       = "${var.project_name}-${random_id.project-id.hex}-kv"
  homepage                   = "https://${var.project_name}-${random_id.project-id.hex}"
  identifier_uris            = ["https://${var.project_name}-${random_id.project-id.hex}"]
  reply_urls                 = ["https://${var.project_name}-${random_id.project-id.hex}"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

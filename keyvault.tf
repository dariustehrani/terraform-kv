resource "azurerm_key_vault" "kv" {
  name                = "${var.project_name}-${random_id.project-id.hex}-kv"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.infra.name}"
  tenant_id           = "${data.azurerm_client_config.current.tenant_id}"

  enabled_for_disk_encryption = false

  sku {
    name = "standard"
  }

  tags = "${var.tags}"
}

resource "azurerm_key_vault_key" "kv-key" {
  name         = "generated-certificate"
  key_vault_id = "${azurerm_key_vault.kv.id}"
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azuread_application" "kv-app" {
  name                       = "${var.project_name}-${random_id.project-id.hex}-kv"
  homepage                   = "https://${var.project_name}-${random_id.project-id.hex}"
  identifier_uris            = ["https://${var.project_name}-${random_id.project-id.hex}"]
  reply_urls                 = ["https://${var.project_name}-${random_id.project-id.hex}"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

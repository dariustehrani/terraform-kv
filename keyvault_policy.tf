resource "azurerm_key_vault_access_policy" "kv-access-policy-devops" {
  vault_name          = "${azurerm_key_vault.kv.name}"
  resource_group_name = "${azurerm_resource_group.infra.name}"

  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  object_id = "${var.devops_sp}"

  key_permissions = [
    "create",
    "get",
    "list",
    "delete",
  ]

  secret_permissions = [
    "set",
    "get",
    "delete",
    "list",
  ]
}

resource "azurerm_key_vault_access_policy" "kv-access-policy-app1" {
  vault_name          = "${azurerm_key_vault.kv.name}"
  resource_group_name = "${azurerm_resource_group.infra.name}"

  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  object_id = "${lookup(azurerm_app_service.app.identity[0], "principal_id")}"
  key_permissions = [
    "get",
  ]

  secret_permissions = [
    "get",
  ]
}

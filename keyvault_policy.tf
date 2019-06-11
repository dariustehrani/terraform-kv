resource "azurerm_key_vault_access_policy" "devops-access-policy-devops" {
  vault_name          = "${azurerm_key_vault.kv.name}"
  resource_group_name = "${var.resource_group_name}"

  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  object_id = "${data.azurerm_client_config.current.service_principal_object_id}"

  key_permissions = [
    "create",
    "get",
  ]

  secret_permissions = [
    "set",
  ]
}

resource "azurerm_key_vault_access_policy" "kv-access-policy-app1" {
  vault_name          = "${azurerm_key_vault.kv.name}"
  resource_group_name = "${var.resource_group_name}"

  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  object_id = "${azurerm_function_app.function-app.principal_id}"

  key_permissions = [
    "get",
  ]

  secret_permissions = [
    "get",
  ]
}

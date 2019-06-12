resource "azurerm_storage_account" "function-sa" {
  name                     = "${var.project_name}functionsa"
  resource_group_name      = "${azurerm_resource_group.infra.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = "${var.tags}"
}

resource "azurerm_app_service_plan" "function-plan" {
  name                = "${var.project_name}-${random_id.project-id.hex}-plan"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.infra.name}"
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = "${var.tags}"
}

resource "azurerm_function_app" "function-app" {
  name                      = "${var.project_name}-${random_id.project-id.hex}"
  location                  = "${var.location}"
  resource_group_name       = "${azurerm_resource_group.infra.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.function-plan.id}"
  storage_connection_string = "${azurerm_storage_account.function-sa.primary_connection_string}"

  identity {
    type = "SystemAssigned"
  }

  site_config {
    linux_fx_version = "DOCKER|(dariustehrani/terraform-kv:latest)"
  }


  app_settings = {
    "KEY_VAULT_URI" = "${azurerm_key_vault.kv.vault_uri}"
  }


  tags = "${var.tags}"
}

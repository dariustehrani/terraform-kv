resource "azurerm_storage_account" "function-sa" {
  name                     = "${var.project_name}-function-sa"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = "${var.tags}"
}

resource "azurerm_app_service_plan" "function-plan" {
  name                = "${var.project_name}-service-plan"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = "${var.tags}"
}

resource "azurerm_function_app" "function-app" {
  name                      = "${var.project_name}-function"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group_name}"
  app_service_plan_id       = "${azurerm_app_service_plan.function-plan.id}"
  storage_connection_string = "${azurerm_storage_account.function-sa.primary_connection_string}"

  identity {
    type = "SystemAssigned"
  } 

  tags = "${var.tags}"
}
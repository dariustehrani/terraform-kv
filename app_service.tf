

resource "azurerm_app_service_plan" "app-service-plan" {
  name                = "${var.project_name}-${random_id.project-id.hex}-plan"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.infra.name}"
  kind                = "Linux"

  sku {
    tier = "Premium"
    size = "P1v2"
  }

  tags = "${var.tags}"
}

resource "azurerm_app_service" "app" {
  name                      = "${var.project_name}-${random_id.project-id.hex}"
  location                  = "${var.location}"
  resource_group_name       = "${azurerm_resource_group.infra.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.app-service-plan}"

  identity {
    type = "SystemAssigned"
  }

  site_config {
    linux_fx_version = "DOCKER|dariustehrani/terraform-kv:latest"
  }


  app_settings = {
    "KEY_VAULT_URI" = "${azurerm_key_vault.kv.vault_uri}"
  }


  tags = "${var.tags}"
}

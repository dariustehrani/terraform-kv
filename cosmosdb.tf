resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "${var.project_name}-cosmosdb"
  resource_group_name = "${azurerm_resource_group.infra.name}"
  location            = "${azurerm_resource_group.infra.location}"
  offer_type          = "Standard"
  consistency_policy {
    consistency_level = "Session"
  }
  geo_location {
    location          = "${azurerm_resource_group.infra.location}"
    failover_priority = 0
  }
  tags = "${var.tags}"
}

resource "azurerm_cosmosdb_sql_database" "cosmosdb-sql-database" {
  name                = "${azurerm_cosmosdb_account.cosmosdb.name}-sql"
  resource_group_name = "${azurerm_resource_group.infra.name}"
  account_name        = "${azurerm_cosmosdb_account.cosmosdb.name}"
}

resource "azurerm_key_vault_secret" "cosmos-db-connection-string" {
  name         = "cosmosdburi"
  value        = "https://${azurerm_cosmosdb_account.cosmosdb.name}.documents.azure.com:443/"
  key_vault_id = "${azurerm_key_vault.kv.id}"

  tags = "${var.tags}"
}

resource "azurerm_key_vault_secret" "cosmos-db-secret" {
  name         = "cosmosdbsecret"
  value        = "${azurerm_cosmosdb_account.cosmosdb.primary_master_key}"
  key_vault_id = "${azurerm_key_vault.kv.id}"

  tags = "${var.tags}"
}

output "cosmosdb_mongodb_connection_string" {
  value     = "mongodb://${azurerm_cosmosdb_account.cosmosdb.name}:${azurerm_cosmosdb_account.cosmosdb.primary_master_key}@${azurerm_cosmosdb_account.cosmosdb.name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  sensitive = true
}



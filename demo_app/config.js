const config = {};

// Azure Managed Identity stuff
const msRestAzure = require('ms-rest-azure');
const KeyVault = require('azure-keyvault');
const KEY_VAULT_URI = null || process.env['KEY_VAULT_URI'];

let clientId = process.env['CLIENT_ID']; // service principal
let domain = process.env['DOMAIN']; // tenant id
let secret = process.env['APPLICATION_SECRET'];


function getKeyVaultCredentials(){
  if (process.env.APPSETTING_WEBSITE_SITE_NAME){
    return msRestAzure.loginWithAppServiceMSI();
  } else {
    return msRestAzure.loginWithServicePrincipalSecret(clientId, secret, domain);
  }
}


var cosmosdbsecret =
function getKeyVaultSecret(credentials) {
  let keyVaultClient = new KeyVault.KeyVaultClient(credentials);
  return keyVaultClient.getSecret(KEY_VAULT_URI, 'cosmosdbsecret', "");
}


config.host = process.env['COSMOSDB_URI'];
config.authKey = (cosmosdbsecret)
config.databaseId = "ToDoList";
config.containerId = "Items";


module.exports = config;
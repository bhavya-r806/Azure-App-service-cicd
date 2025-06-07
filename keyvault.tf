resource "azurerm_key_vault" "kv" {
  name                     = "kv-dotnet-${random_string.suffix.result}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id                = var.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = true
}

resource "azurerm_role_assignment" "keyvault_access" {
  scope                = azurerm_key_vault.my_kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = "891ced47-c1cb-475b-8345-f1819eddf85a"  # 👈 your SP object ID
}

 # or system identity


resource "azurerm_key_vault_secret" "example" {
  name         = "DbPassword"
  value        = "SuperSecret123"
  key_vault_id = azurerm_key_vault.kv.id
 
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

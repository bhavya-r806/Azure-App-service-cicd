resource "azurerm_key_vault" "kv" {
  name                     = "kv-dotnet-${random_string.suffix.result}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id                = var.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = true
}

resource "azurerm_role_assignment" "keyvault_access" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = "b5d31d33-9a2f-4f7e-a2f5-cfaa7bacc64d" # 👈 your SP object ID
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

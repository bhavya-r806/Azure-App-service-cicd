resource "azurerm_key_vault" "kv" {
  name                     = "kv-dotnet-${random_string.suffix.result}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id                = var.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = true
}

resource "azurerm_key_vault_secret" "example" {
  name         = "DbPassword"
  value        = "SuperSecret123"
  key_vault_id = azurerm_key_vault.kv.id
}

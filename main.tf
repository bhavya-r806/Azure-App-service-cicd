provider "azurerm" {
  features {}
  subscription_id = "fd240ce0-897d-4c0e-a243-662d89ccda9a"

}
resource "azurerm_resource_group" "app-rg" {
  name     = var.resource_group_name
  location = var.location

}


resource "azurerm_app_service_plan" "asp" {
  name                = "dotnet-asp"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "dotnetapp-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    dotnet_framework_version = "v4.0"

  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
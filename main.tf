provider "azurerm" {
  features {}
  subscription_id = "fd240ce0-897d-4c0e-a243-662d89ccda9a"
}


resource "azurerm_resource_group" "app-rg" {
  name     = var.resource_group_name
  location = var.location

}


resource "azurerm_service_plan" "asp" {
  name                = "dotnet-asp"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Windows" # or "Linux"
  sku_name            = "B1"


}

resource "azurerm_linux_web_app" "app" {
  name                = "dotnetapp-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
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
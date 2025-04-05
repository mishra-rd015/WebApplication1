provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "rg-jenkins"
  location = "East US"
}

resource "azurerm_service_plan" "this" {
  name                = "jenkins-app-service-plan"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Windows"
  sku_name            = "B1"
}

resource "azurerm_windows_web_app" "this" {
  name                = "jenkins-flask-app"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on = true
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}

provider "azurerm" {
  features {}

  subscription_id = "4947feb5-b5f6-4284-acce-df1b262aedb0"
  client_id       = "16a790e6-0069-4397-af16-1c0f0ca9a9bf"
  client_secret   = "cXo8Q~wv3nv3g5WUCddUyxIoA0Hvh64OOVMabaJ6"
  tenant_id       = "2ab9811e-8172-4cd1-bf22-858c28b732da"
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

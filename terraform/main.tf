provider "azurerm" {
  features {}
  subscription_id = "4947feb5-b5f6-4284-acce-df1b262aedb0"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-jenkins"
  location = "East US"  # Replace with your desired location or var.location
}

resource "azurerm_service_plan" "this" {
  name                = "appserviceplan-jenkins"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"  # Required argument, specify "Linux" or "Windows"

  sku {
    tier = "Basic"  # SKU tier, modify according to your needs
    size = "B1"     # SKU size, modify according to your needs
  }
}

resource "azurerm_linux_web_app" "this" {
  name                = "webapijenkinshardik827813"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on = true
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14.15"
  }

  tags = {
    environment = "production"
  }
}

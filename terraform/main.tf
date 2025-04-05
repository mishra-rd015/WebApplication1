provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_service_plan" "example" {  # Updated resource type
  name                = "example-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Windows"
  reserved            = false

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_windows_web_app" "this" {
  name                = "example-web-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id  # Corrected argument name

  site_config {
    # scm_type is removed because Terraform will auto-decide it
    # other site_config options, if any, should be configured here
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14.15"
  }

  tags = {
    environment = "production"
  }
}

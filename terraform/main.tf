provider "azurerm" {
  features {}
}

# Define Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

# Define Service Plan
resource "azurerm_service_plan" "example" {
  name                = "example-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Windows"        # Use "Windows" for Windows-based apps, "Linux" for Linux-based apps
  reserved            = false            # Set to false for Windows, true for Linux

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Define Windows Web App
resource "azurerm_windows_web_app" "this" {
  name                = "example-web-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id  # Correct argument

  site_config {
    # Auto-decided SCM type by Terraform, but you can configure other site options if needed
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14.15"  # Example app setting, modify as needed
  }

  tags = {
    environment = "production"  # Example tags, modify as needed
  }
}

# Optional: If you need to deploy a database or other resources, you can add them here.

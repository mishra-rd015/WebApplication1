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
  
  sku_name            = "B1"     # Pricing tier (e.g., B1, S1, P1V2)
  sku_tier            = "Basic"  # SKU tier (Basic, Standard, Premium, etc.)

  # Optional: Configure the number of workers (for scaling purposes)
  # reserved            = true    # If you are using Linux, set this to true
}

resource "azurerm_linux_web_app" "this" {
  name                = "webapijenkinshardik827813"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on = true  # Keeps the app always running
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14.15"  # Node.js version
  }

  tags = {
    environment = "production"
  }
}

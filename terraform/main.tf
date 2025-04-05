provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg_jenkins" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "appserviceplan_jenkins" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg_jenkins.location
  resource_group_name = azurerm_resource_group.rg_jenkins.name
  os_type             = "Linux"

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
}

resource "azurerm_linux_web_app" "jenkins_app" {
  name                = var.web_app_name
  location            = azurerm_resource_group.rg_jenkins.location
  resource_group_name = azurerm_resource_group.rg_jenkins.name
  service_plan_id     = azurerm_service_plan.appserviceplan_jenkins.id

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

provider "azurerm" {
  features {}
  subscription_id = "4947feb5-b5f6-4284-acce-df1b262aedb0"
}

variable "location" {
  default = "East US"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-jenkins-new"
  location = var.location
}

resource "azurerm_service_plan" "this" {
  name                = "appserviceplan-jenkins"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "this" {
  name                = "webapijenkinsrudram015"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on  = true
    ftps_state = "Disabled"

    # Optional runtime — uncomment and set correct one if needed
    # linux_fx_version = "NODE|18-lts"  # For Node.js
    # linux_fx_version = "DOTNETCORE|6.0"  # For .NET Core
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "SCM_DO_BUILD_DURING_DEPLOYMENT"      = "true"
  }
}

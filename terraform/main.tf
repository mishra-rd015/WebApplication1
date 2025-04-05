terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-jenkins"
    storage_account_name = "flasktfstorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  subscription_id = "4947feb5-b5f6-4284-acce-df1b262aedb0"
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
    always_on               = true
    managed_pipeline_mode   = "Integrated"
    scm_type                = "LocalGit"
    ftps_state              = "Disabled"
    use_32_bit_worker       = true
    websockets_enabled      = false
    http2_enabled           = false
    ip_restriction_default_action = "Allow"
    scm_ip_restriction_default_action = "Allow"
    minimum_tls_version     = "1.2"
    scm_minimum_tls_version = "1.2"
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }

  https_only = false
}

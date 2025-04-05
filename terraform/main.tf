terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26.0"
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
  client_id       = "16a790e6-0069-4397-af16-1c0f0ca9a9bf"
  client_secret   = "cXo8Q~wv3nv3g5WUCddUyxIoA0Hvh64OOVMabaJ6"
  tenant_id       = "2ab9811e-8172-4cd1-bf22-858c28b732da"
}

resource "azurerm_resource_group" "rg_jenkins" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "appserviceplan_jenkins" {
  name                = var.service_plan_name
  location            = azurerm_resource_group.rg_jenkins.location
  resource_group_name = azurerm_resource_group.rg_jenkins.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "jenkins_app_12345" {
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

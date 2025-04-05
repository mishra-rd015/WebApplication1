variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = "4947feb5-b5f6-4284-acce-df1b262aedb0"
}

variable "client_id" {
  description = "Azure Service Principal Client ID"
  type        = string
  default     = "16a790e6-0069-4397-af16-1c0f0ca9a9bf"
}

variable "client_secret" {
  description = "Azure Service Principal Client Secret"
  type        = string
  default     = "cXo8Q~wv3nv3g5WUCddUyxIoA0Hvh64OOVMabaJ6"
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = "2ab9811e-8172-4cd1-bf22-858c28b732da"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "rg-jenkins"
}

variable "location" {
  description = "Azure Location"
  type        = string
  default     = "East US"
}

variable "app_service_plan_name" {
  description = "App Service Plan Name"
  type        = string
  default     = "appserviceplan-jenkins"
}

variable "sku_tier" {
  description = "SKU Tier"
  type        = string
  default     = "Basic"
}

variable "sku_size" {
  description = "SKU Size"
  type        = string
  default     = "B1"
}

variable "web_app_name" {
  description = "Web App Name"
  type        = string
  default     = "jenkins-app-12345"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my_firts_azure_group" {
  name     = var.group_name
  location = var.group_location
}

resource "azurerm_app_service_plan" "my_firts_azure_plan" {
  name                = var.plan_name
  location            = azurerm_resource_group.my_firts_azure_group.location
  resource_group_name = azurerm_resource_group.my_firts_azure_group.name
  os_type             = var.os_type_name
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "my_firts_azure_web_app" {
  name                = var.web_app_name
  resource_group_name = azurerm_resource_group.my_firts_azure_group.name
  location            = azurerm_service_plan.my_firts_azure_group.location
  service_plan_id     = azurerm_service_plan.my_firts_azure_plan.id

  site_config {
    always_on = false
    application_stack {
      docker_image     = var.docker_image
      docker_image_tag = var.image_version
    }
  }
}
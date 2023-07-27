variable "group_name" {
  type        = string
  default     = "eastus"
  description = "name of resource group"
}

variable "group_location" {
  type        = string
  default     = "West Europe"
  description = "name location of create group"
}

variable "plan_name" {
  type        = string
  default     = "my-firts-plan"
  description = "create name of plan"
}

variable "os_type_name" {
  type        = string
  default     = "Linux"
  description = "define os type of service plan"
}

variable "sku_name" {
  type        = string
  default     = "F1"
  description = "name of sku"
}

variable "web_app_name" {
  type        = string
  default     = "my_firts_azure_web_app"
  description = "define name of web app"
}

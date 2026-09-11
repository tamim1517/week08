variable "subscription_id" {
  description = "Azure subscription ID used by Terraform."
  type        = string
}

variable "location" {
  description = "Azure region for the Week 08 resources."
  type        = string
  default     = "Australia East"
}

variable "resource_group_name" {
  description = "Resource Group containing the Week 08 resources."
  type        = string
}

variable "acr_name" {
  description = "Globally unique Azure Container Registry name."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9]{5,50}$", var.acr_name))
    error_message = "ACR name must be 5-50 alphanumeric characters with no hyphens."
  }
}

variable "storage_account_name" {
  description = "Globally unique Azure Storage Account name."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage Account name must be 3-24 lowercase letters/numbers only."
  }
}

variable "aks_cluster_name" {
  description = "Name of the Azure Kubernetes Service cluster."
  type        = string
}

variable "aks_dns_prefix" {
  description = "DNS prefix used by AKS."
  type        = string
}

variable "aks_node_count" {
  description = "Number of nodes in the default AKS node pool."
  type        = number
  default     = 2
}

variable "aks_node_vm_size" {
  description = "VM SKU used by AKS worker nodes."
  type        = string
  default     = "Standard_D2s_v5"
}

variable "environment" {
  description = "Environment label used in tags."
  type        = string
  default     = "development"
}

variable "tags" {
  description = "Common tags applied to Azure resources."
  type        = map(string)

  default = {
    Project     = "SIT722 Week08"
    ManagedBy   = "Terraform"
    Practical   = "8.1P"
    Environment = "Development"
  }
}

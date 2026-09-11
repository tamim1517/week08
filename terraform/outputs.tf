output "resource_group_name" {
  description = "Resource Group created for Week 08."
  value       = azurerm_resource_group.rg.name
}

output "acr_name" {
  description = "Azure Container Registry name."
  value       = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "ACR login server used in Kubernetes image references."
  value       = azurerm_container_registry.acr.login_server
}

output "storage_account_name" {
  description = "Azure Storage Account name."
  value       = azurerm_storage_account.storage.name
}

output "storage_connection_string" {
  description = "Storage connection string. Treat this as a secret."
  value       = azurerm_storage_account.storage.primary_connection_string
  sensitive   = true
}

output "aks_cluster_name" {
  description = "AKS cluster name."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_node_resource_group" {
  description = "Azure-managed node resource group created for AKS."
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "aks_get_credentials_command" {
  description = "Command to connect kubectl to the new AKS cluster."
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.rg.name} --name ${azurerm_kubernetes_cluster.aks.name} --overwrite-existing"
}

output "acr_login_command" {
  description = "Command to log Docker/Azure CLI into the ACR."
  value       = "az acr login --name ${azurerm_container_registry.acr.name}"
}

output "github_actions_values" {
  description = "Non-secret values commonly needed in the Week 08 workflows."
  value = {
    RESOURCE_GROUP       = azurerm_resource_group.rg.name
    ACR_NAME             = azurerm_container_registry.acr.name
    ACR_LOGIN_SERVER     = azurerm_container_registry.acr.login_server
    AKS_CLUSTER_NAME     = azurerm_kubernetes_cluster.aks.name
    STORAGE_ACCOUNT_NAME = azurerm_storage_account.storage.name
  }
}

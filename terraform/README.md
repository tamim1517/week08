# Week 08 Terraform

This folder provisions the Azure infrastructure required by SIT722 Week 08 using the same general approach as Week 06:

- Resource Group
- Azure Container Registry (ACR)
- Azure Kubernetes Service (AKS)
- Azure Storage Account
- `AcrPull` role assignment so AKS can pull private images from ACR

The official Week 08 repository requires these Azure resources but does not include Terraform files itself.

## 1. Login and get the subscription ID

```powershell
az login
az account show -o table
az account show --query id -o tsv
```

Copy the subscription ID into `terraform.tfvars`.

## 2. Review the names

Default values:

- Resource Group: `koalatech-week08-rg`
- ACR: `koala722acr81p0904`
- Storage Account: `koala722st810904`
- AKS: `koala-sit722-aks-81p`

ACR and Storage Account names are global. If Azure reports that a name already exists, change it in `terraform.tfvars`.

## 3. Provision

```powershell
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Enter `yes` when prompted.

## 4. Read the useful outputs

```powershell
terraform output
terraform output -json github_actions_values
```

Do not display `storage_connection_string` in screenshots.

## 5. Connect to AKS

```powershell
az aks get-credentials --resource-group koalatech-week08-rg --name koala-sit722-aks-81p --overwrite-existing
kubectl get nodes
```

## 6. Login to ACR

```powershell
az acr login --name koala722acr81p0904
```

Use the ACR login server in Week 08 Kubernetes manifests:

```text
koala722acr81p0904.azurecr.io/<image-name>:<tag>
```

## 7. GitHub Actions service principal

The Week 08 README asks for a separate service principal and a GitHub secret named `AZURE_CREDENTIALS`.
This Terraform set intentionally does not create the Entra service principal because CloudLabs permissions can vary.

After Terraform creates the Resource Group, create the service principal with Azure CLI:

```powershell
$scope = az group show --name koalatech-week08-rg --query id -o tsv

az ad sp create-for-rbac `
  --name "student722-week08-gha" `
  --role Owner `
  --scopes $scope
```

Save the returned `appId`, `password`, and `tenant`, then get the subscription ID:

```powershell
az account show --query id -o tsv
```

Create the GitHub `AZURE_CREDENTIALS` secret in the JSON format expected by your Week 08 workflow.

## 8. Cleanup

Take all required screenshots first, then:

```powershell
terraform destroy
```

If the service principal was created separately, delete it separately after the practical.

## CloudLabs Resource Group permission note

If `terraform apply` fails specifically with:

```text
Microsoft.Resources/subscriptions/resourceGroups/write
AuthorizationFailed
```

your CloudLabs account cannot create a new Resource Group at subscription scope. In that case, do not repeatedly retry. Use an existing permitted Resource Group and change `resource_group.tf` to a data source, as done when handling restricted CloudLabs accounts.

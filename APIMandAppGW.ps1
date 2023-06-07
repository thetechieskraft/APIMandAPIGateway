# Deploy an Azure API-M instance in Internal VNET mode with an Application Gateway 

# Login to Azure 
Connect-AzAccount

# Set subscription
$subscriptionId = "#######-#######-####-#####-############"     #  GUID of target Azure subscription
Get-AzSubscription -Subscriptionid $subscriptionId | Select-AzSubscription

# ------------- Prerequisites  Task List------------- #
    #1. Create Certificate for your custom domain
    #2. Create the Virtual Network
    #3. Create an Azure Key Vault to store keys
    #4. Create a User Managed Identity for App Gateway to access Key Vault

# Create resource group
$resGroupName           = "apimAndapigateway-rg"                           # resource group name
$location               = "UK South"                                        # Azure region
$kv                     = "shivapim-kv"                                     # Azure Key Vault
$kvUserIdentity         = "att-kv-user"                                     # Azure Key Vault

New-AzResourceGroup -Name $resGroupName -Location $location

New-AzKeyVault -Name $kv -ResourceGroupName $resGroupName -Location $location

New-AzUserAssignedIdentity -ResourceGroupName $resGroupName -Name $kvUserIdentity -Location $location

# Create subnet config for Application Gateway
$appgatewaysubnet = New-AzVirtualNetworkSubnetConfig -Name "appgw-subnet" -AddressPrefix "10.0.0.0/24"

# Create subnet config for API-M
$apimsubnet = New-AzVirtualNetworkSubnetConfig -Name "apim-subnet" -AddressPrefix "10.0.1.0/24"

# Create VNET and assign subnets
$vnet = New-AzVirtualNetwork -Name "apimAndapigateway-vnet" -ResourceGroupName $resGroupName -Location $location -AddressPrefix "10.0.0.0/16" -Subnet $appgatewaysubnet,$apimsubnet

# Assign subnet variables
$appgatewaysubnetdata = $vnet.Subnets[0]
$apimsubnetdata = $vnet.Subnets[1]

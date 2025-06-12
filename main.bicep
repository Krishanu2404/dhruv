targetScope = 'subscription'

@description('Name of the resource group')
param resourceGroupName string

@description('Region of the resource group')
param location string = 'eastus'

resource dhruvRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
    name: resourceGroupName 
    location: location
}

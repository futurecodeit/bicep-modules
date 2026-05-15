@description('Resource Group Objects')
param resourceGroup object
@description('Tags to be applied to the Resource Group')
param tags object = {}

targetScope='subscription'

resource newRG 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroup.name
  location: resourceGroup.location
  tags: tags
}

output resourceGroupId string = newRG.id
output resourceGroupName string = newRG.name
output resourceGroupLocation string = newRG.location

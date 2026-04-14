@description('Name of the Resource Group')
param rgName string
@description('Location of the Resource Group')
param rgLocation string
@description('Tags to be applied to the Resource Group')
param tags object = {}

targetScope='subscription'

resource newRG 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: rgName
  location: rgLocation
  tags: tags
}

output resourceGroupId string = newRG.id
output resourceGroupName string = newRG.name
output resourceGroupLocation string = newRG.location

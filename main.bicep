// targetScope = 'subscription'

param bicepRG object 

param bicepSubscription string = bicepRG.subscriptionName

param bicepRGName string = bicepRG.rgName

param tags object

param location string = bicepRG.location

param moduletoDeploy string

param virtualNetworks array 

module rg './resource-group/rg.bicep' = if (contains(moduletoDeploy, 'resourceGroup')) {
  scope: subscription()
  name: 'rgDeployment'
  params: {
    rgName: bicepRGName
    rgLocation: location
    tags: tags
  }
}

module vnet './virtual-network/vnet.bicep' = if (contains(moduletoDeploy, 'virtualNetwork')) {
  scope: resourceGroup(bicepSubscription, bicepRGName)
  name: 'vnetDeployment'
  params: {
    tags: tags
    virtualNetworks: virtualNetworks
  }
}

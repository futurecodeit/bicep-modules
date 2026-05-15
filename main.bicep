targetScope = 'subscription'
param moduletoDeploy string = 'resourceGroup'
param tags object

param parametersContent object

var objects = parametersContent

var resourceGroupParam = objects.resourceGroupParam

var vnet = objects.vnet


module rg './resource-group/rg.bicep' = if (moduletoDeploy == 'resourceGroup') {
  //scope: subscription()
  name: 'rgDeployment'
  params: {
    resourceGroup:  resourceGroupParam
    tags: tags
  }
}

module virtualNetwork './virtual-network/virtual-network.bicep' = if (moduletoDeploy == 'virtualNetwork') {
  scope: resourceGroup(resourceGroupParam.name)
  name: 'vnetDeployment'
  params: {
    tags: tags
    vnet: vnet
    location: resourceGroupParam.location
  }
  dependsOn: [
    rg
  ]
}

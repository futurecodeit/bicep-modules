targetScope = 'subscription'

param bicepRG object 

param bicepSubscription string = bicepRG.subscriptionName

param bicepRGName string = bicepRG.rgName

param tags object

param location string = bicepRG.location

param moduletoDeploy string

module rg '../../resource-group/rg.bicep' = if (contains(moduletoDeploy, 'resourceGroup')) {
  scope: subscription(bicepSubscription)
  name: 'rgDeployment'
  params: {
    rgName: bicepRGName
    rgLocation: location
    tags: tags
  }
}

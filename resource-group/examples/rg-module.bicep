targetScope = 'subscription'

param bicepRG object 

param bicepSubscription string = bicepRG.subscriptionName

param bicepRGName string = bicepRG.name

param tags object

param location string

module rg '../rg.bicep' = {
  scope: subscription(bicepSubscription)
  name: 'rgDeployment'
  params: {
    rgName: bicepRGName
    rgLocation: location
    tags: tags
  }
}

param location string
param tags object = {}
param vnet object

resource virtualNetworkResource 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: vnet.name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet.addressPrefix
      ]
    }
    subnets: [
      {
        name: vnet.subnetName
        properties: {
          addressPrefix: vnet.subnetAddressPrefix
        }
      }
    ]
  }
}

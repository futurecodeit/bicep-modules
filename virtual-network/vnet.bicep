@description('Common tags applied to resources')
param tags object

@description('Object containing all virtual networks to deploy')
param virtualNetworks array

resource vnet 'Microsoft.Network/virtualNetworks@2025-05-01' = [
  for (vnetKey, index) in virtualNetworks: {
    name: virtualNetworks[vnetKey].name
    location: virtualNetworks[vnetKey].location

    extendedLocation: virtualNetworks[vnetKey].extendedLocation

    tags: tags

    properties: {
      addressSpace: {
        addressPrefixes: virtualNetworks[vnetKey].addressSpace.addressPrefixes
        ipamPoolPrefixAllocations: map(virtualNetworks[vnetKey].addressSpace.ipamPoolPrefixAllocations, alloc => {
          numberOfIpAddresses: alloc.numberOfIpAddresses
          pool: {
            id: alloc.pool.id
          }
        })
      }

      bgpCommunities: {
        virtualNetworkCommunity: virtualNetworks[vnetKey].bgpCommunities.virtualNetworkCommunity
      }

      ddosProtectionPlan: virtualNetworks[vnetKey].ddosProtectionPlan != null ? {
        id: virtualNetworks[vnetKey].ddosProtectionPlan.id
      } : null

      enableDdosProtection: virtualNetworks[vnetKey].enableDdosProtection
      enableVmProtection: virtualNetworks[vnetKey].enableVmProtection

      encryption: {
        enabled: virtualNetworks[vnetKey].encryption.enabled
        enforcement: virtualNetworks[vnetKey].encryption.enforcement
      }

      dhcpOptions: {
        dnsServers: virtualNetworks[vnetKey].dnsServers
      }

      flowTimeoutInMinutes: virtualNetworks[vnetKey].flowTimeoutInMinutes

      ipAllocations: map(virtualNetworks[vnetKey].ipAllocations, ipa => {
        id: ipa.id
      })

      privateEndpointVNetPolicies: virtualNetworks[vnetKey].privateEndpointVNetPolicies

      subnets: map(items(virtualNetworks[vnetKey].subnets), subnet => {
        id: subnet.value.id
        name: subnet.key

        properties: {
          addressPrefix: subnet.value.addressPrefix
          addressPrefixes: subnet.value.addressPrefixes

          applicationGatewayIPConfigurations: map(subnet.value.applicationGatewayIPConfigurations, ag => {
            id: ag.id
            name: ag.name
            properties: {
              subnet: {
                id: ag.properties.subnet.id
              }
            }
          })

          defaultOutboundAccess: subnet.value.defaultOutboundAccess

          delegations: map(subnet.value.delegations, del => {
            id: del.id
            name: del.name
            type: del.type
            properties: {
              serviceName: del.properties.serviceName
            }
          })

          ipAllocations: map(subnet.value.ipAllocations, ipa => {
            id: ipa.id
          })

          ipamPoolPrefixAllocations: map(subnet.value.ipamPoolPrefixAllocations, alloc => {
            numberOfIpAddresses: alloc.numberOfIpAddresses
            pool: {
              id: alloc.pool.id
            }
          })

          natGateway: subnet.value.natGateway != null ? {
            id: subnet.value.natGateway.id
          } : null

          networkSecurityGroup: subnet.value.networkSecurityGroup != null ? {
            id: subnet.value.networkSecurityGroup.id
          } : null

          privateEndpointNetworkPolicies: subnet.value.privateEndpointNetworkPolicies
          privateLinkServiceNetworkPolicies: subnet.value.privateLinkServiceNetworkPolicies

          routeTable: subnet.value.routeTable != null ? {
            id: subnet.value.routeTable.id
          } : null

          serviceEndpointPolicies: map(subnet.value.serviceEndpointPolicies, sep => {
            id: sep.id
          })

          serviceEndpoints: map(subnet.value.serviceEndpoints, se => {
            service: se.service
            locations: se.locations
          })

          serviceGateway: subnet.value.serviceGateway != null ? {
            id: subnet.value.serviceGateway.id
          } : null

          sharingScope: subnet.value.sharingScope
        }
      })

      virtualNetworkPeerings: map(virtualNetworks[vnetKey].virtualNetworkPeerings, peering => {
        id: peering.id
        name: peering.name
        properties: peering.properties
      })
    }
  }
]

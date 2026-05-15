using '../../main.bicep'

param resourceGroupParam = {
  name: 'ghesdemo'
  location: 'uksouth'
}

param tags = {
  owner: 'nacho'
  workload: 'ghes'
  application: 'Github Enterprise Server'
  env: 'lab'
}

param vnet = {
  name: 'ghes-vnet'
  subnetName: 'default'
  addressPrefix: '10.0.0.0/16'
  subnetAddressPrefix: '10.0.2.0/24'
}

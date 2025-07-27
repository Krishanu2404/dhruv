@description('service bus namespace')
param serviceBusNameSpace string

@description('name of the queue')
param queueName string

@description('Location')
param location string = resourceGroup().location

resource sbNamespace 'Microsoft.ServiceBus/namespaces@2024-01-01' = {
  name: serviceBusNameSpace
  location:location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
  properties: {
    isAutoInflateEnabled: false
    maximumThroughputUnits: 0
  }
}

resource sbQueue 'Microsoft.ServiceBus/namespaces/queues@2024-01-01' = {
  name: '${serviceBusNameSpace}/${queueName}'
  properties: {
    lockDuration: 'PT2M'
    defaultMessageTimeToLive: 'P7D'
    deadletteringOnMessageExpiration: true
  }
  dependsOn: [
    sbNamespace
  ]
}

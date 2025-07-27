param storageAccountName string
param serviceBusNamespace string
param serviceBusQueueName string

resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storageAccountName
}

resource serviceBusQueue 'Microsoft.ServiceBus/namespaces/queues@2024-01-01' existing = {
  name: '${serviceBusNamespace}/${serviceBusQueueName}'
}

resource eventSubscription 'Microsoft.EventGrid/eventSubscriptions@2025-02-15' = {
  name: 'embeddingGeneratorEventSubscription'
  scope: storage
  properties: {
    destination: {
      endpointType: 'ServiceBusQueue'
      properties: {
        resourceId: serviceBusQueue.id 
      }
    }
    filter: {
      includedEventTypes: [
        'Microsoft.Storage.BlobCreated'
      ]
    }
    eventDeliverySchema: 'EventGridSchema'
  }
}

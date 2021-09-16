param storageName string // must be globally unique
param storageSku string = 'Standard_LRS'
param location string = resourceGroup().location

resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
    name: storageName
    location: location
    kind: 'Storage'
    sku: {
        name: storageSku // reference variable
    }
}

output storageId string = stg.id // output resourceId of storage account

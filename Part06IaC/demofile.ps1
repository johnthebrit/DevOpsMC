#Create a storage account
#DEMO1
New-AzStorageAccount -ResourceGroupName RG_PolicyTest `
  -Name 'savilldemoavailable' `
  -Location northeurope `
  -SkuName Standard_ZRS `
  -Kind StorageV2

$errorlast = get-error
$errorlast.Exception.Response.Content | ConvertFrom-Json | convertto-json -Depth 100


#Bicep deploy
#DEMO2
cd .\Part06IaC
New-AzResourceGroupDeployment -TemplateFile "storageaccount.bicep" -ResourceGroupName RG_PolicyTest `
    -TemplateParameterFile "storageaccount-dev.bad.parameters.json" `
    -WhatIf

New-AzResourceGroupDeployment -TemplateFile "storageaccount.bicep" -ResourceGroupName RG_PolicyTest `
    -TemplateParameterFile "storageaccount-dev.parameters.json" `
    -WhatIf

#Actually deploy
New-AzResourceGroupDeployment -TemplateFile "storageaccount.bicep" -ResourceGroupName RG_PolicyTest `
    -TemplateParameterFile "storageaccount-dev.parameters.json"

#Declarative so can run again and update my new desired state
New-AzResourceGroupDeployment -TemplateFile "storageaccount.bicep" -ResourceGroupName RG_PolicyTest `
    -TemplateParameterFile "storageaccount-dev.parameters.json" `
    -storageSku 'Standard_GRS'

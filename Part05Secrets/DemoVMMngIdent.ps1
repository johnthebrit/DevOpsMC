Connect-AzAccount -Identity
Get-AzContext

#Note the -UseConnectedAccount to connect to storage using AAD data plane instead of account keys
New-AzStorageContext -UseConnectedAccount -StorageAccountName sascussavilltech `
    | Get-AzStorageBlobContent -Container 'images' -Blob 'OllieandEddieCerealEating.jpg' -Destination d:\

#View the service principal for the resource
Get-AzADServicePrincipal -DisplayNameBeginsWith DemoVM #VM

#View the system-assigned identity
$VM = Get-AzVM -ResourceGroupName RG-DemoVM -Name DemoVM
$VM.Identity.PrincipalId

#Interact with Key Vault
$secret = Get-AzKeyVaultSecret -VaultName 'SavillVaultRBAC' -Name 'Secret1'
$text = $secret.SecretValue | ConvertFrom-SecureString -AsPlainText
write-output $text
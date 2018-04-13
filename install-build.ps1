param( [string]$location )

# fix name, make server name fully qualified
$serverName = ([uri]$location).Host.ToLower()
$location = $location.ToLower().Replace($serverName, "$serverName.k2workflow.com")
Write-Host "Installing build: $location"

if (!$(Test-Path $location))
{
    throw [System.IO.FileNotFoundException] "$location not found."
}

Import-Module BitsTransfer

$workDir = "c:\install\"
if (Test-Path $workDir) 
{
    Remove-Item $workDir -Force -Recurse
}   
New-Item $workDir -ItemType Directory

Set-Location $workDir

$sourceExe =  $(Get-ChildItem "$location\MSI\*.exe")[0]
Start-BitsTransfer -Source $sourceExe.FullName -Destination $workDir -Description "Copy build from server to local folder" -DisplayName "Copy Build"

Write-Host "Extract build"
Start-Process "$workDir\$($sourceExe.Name)" -ArgumentList '-y -nr' -Wait

Write-Host "Install build"
Start-Process $($(Get-ChildItem "$workDir\SourceCode.SetupManager.exe" -Recurse)[0].FullName) -ArgumentList '-a' -Wait
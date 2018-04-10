if ($(Get-ExecutionPolicy) -ne "Unrestricted") 
{
    Set-ExecutionPolicy Bypass -Force
}

function Add-Shortcut
{
    param( [string]$fileLocation, [string]$targetPath )

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($fileLocation)
    $Shortcut.TargetPath = $targetPath
    $Shortcut.Save()
}

$servers = @("sa-build01-v.k2workflow.com", 
             "sa-build02-v.k2workflow.com", 
             "sa-build03-v.k2workflow.com", 
             "sa-build04-v.k2workflow.com", 
             "sa-build05-v.k2workflow.com", 
             "sa-build06-v.k2workflow.com")

$folder = "$home\Desktop\Links\"

if (Test-Path $folder) 
{
    Remove-Item $folder
}   

New-Item $folder -ItemType Directory

foreach ($server in $servers)
{
    Add-Shortcut "$folder\$server.lnk" "\\$server\Builds\"
}

Add-Shortcut "$folder\Add App to Sharepoint.lnk" "https://portal.denallix.com/sites/AppCatalog/_layouts/15/addanapp.aspx?Source=https%3A%2F%2Fportal%2Edenallix%2Ecom%2Fsites%2FAppCatalog%2F%5Flayouts%2F15%2Fviewlsts.aspx"
Write-Host "Done!"
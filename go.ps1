if ($(Get-ExecutionPolicy) -ne "Unrestricted") 
{
    Set-ExecutionPolicy Bypass -Force
}

function Create-Shortcut
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

$folder = "$home\Desktop"

if (!(Test-Path $folder)) 
{
    New-Item $folder
}   

foreach ($server in $servers)
{
  Create-Shortcut "$folder\$server.lnk" "\\$server\Builds\"
}

Create-Shortcut "$folder\Add App to Sharepoint.lnk" "https://portal.denallix.com/sites/AppCatalog/_layouts/15/addanapp.aspx?Source=https%3A%2F%2Fportal%2Edenallix%2Ecom%2Fsites%2FAppCatalog%2F%5Flayouts%2F15%2Fviewlsts.aspx"

Write-Host "Done!"
Read-Host "Did it work?"
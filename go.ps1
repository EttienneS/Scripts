$servers = @("sa-build01-v.k2workflow.com", 
             "sa-build02-v.k2workflow.com", 
             "sa-build03-v.k2workflow.com", 
             "sa-build04-v.k2workflow.com", 
             "sa-build05-v.k2workflow.com", 
             "sa-build06-v.k2workflow.com")

$folder = "$home\Desktop\Links"

if (!(Test-Path $folder)) 
{
    New-Item $folder
}   

foreach ($server in $servers)
{
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$folder\$server.lnk")
    $Shortcut.TargetPath = "\\$server\Builds\"
    $Shortcut.Save()
}

Write-Host "Done!"
Read-Host "Press any key to exit."
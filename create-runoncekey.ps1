if ($(Get-ExecutionPolicy) -ne "Unrestricted") 
{
    Set-ExecutionPolicy Bypass -Force
}
Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name 'Go' -Value 'c:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -command "iex ((New-Object System.Net.WebClient).DownloadString(''https://raw.githubusercontent.com/EttienneS/Scripts/master/go.ps1''))"'Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name 'Go' -Value 'c:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -command "iex ((New-Object System.Net.WebClient).DownloadString(''https://raw.githubusercontent.com/EttienneS/Scripts/master/go.ps1''))"'Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name 'Go' -Value 'c:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -command "iex ((New-Object System.Net.WebClient).DownloadString(''https://raw.githubusercontent.com/EttienneS/Scripts/master/go.ps1''))"'tienneS/Scripts/master/go.ps1''))"'
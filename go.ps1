$scriptCache = @{}

function Get-RepositoryScript
{
    param( [string]$scriptName )

    if (!$scriptCache.ContainsKey($scriptName))
    {
        $scriptFile = ".\$scriptName.ps1"

        # if the file does not exist locally, get it.
        if (!$(Test-Path $scriptFile))
        {
            (New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/EttienneS/Scripts/master/$scriptName.ps1", $scriptFile)      
        }      
        
        $scriptCache.Add($scriptName, $scriptFile)
    }
    
    $scriptCache[$scriptName]
}

# ensure all scripts that that we require are present on disk
$getbuildScript = $(Get-RepositoryScript "get-build")
$installbuildScript = $(Get-RepositoryScript "install-build")
$shortcutScript = $(Get-RepositoryScript "add-commonshortcuts")

# add several shortcuts to important local servers
#& $shortcutScript

# prompt the user for a build
$build = & $getbuildScript -Prompt

# if a build is returned, install it.
if ($build)
{
    & $installbuildScript $build.dropLocation
}


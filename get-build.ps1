Param([switch]$q,[string]$build)

$ErrorActionPreference = 'Stop'

# get a credential object from a trusted local server
$credential = (Invoke-Expression $(Get-Content "\\scinstall.k2workflow.com\public\get-creds.ps1"))

if ($build)
{
    $buildDefinitions = @($build)
}
else 
{
    $buildDefinitions = @("Main", "K2Cloud_004_R0","K2Five_002_R0")    
}

$maxBuilds = 30;
$date = (Get-Date).AddDays(-1).ToString("yyyy-MM-dd")

Write-Host "# of builds to return:  " $maxBuilds
Write-Host "Return builds from:     " $date

$results = New-Object System.Collections.ArrayList

foreach ($buildDefinition in $buildDefinitions)
{
    $request = "http://tfs.k2.com:8080/tfs/Labs/K2%202014/_apis/build/builds?definition=${buildDefinition}&status=Succeeded&minFinishTime=${date}&api-version=1.0"
    
    Write-Host "Build Definitions:      " $buildDefinition
    
    $requestedResults = Invoke-WebRequest $request -Credential $credential | ConvertFrom-Json
    $results.AddRange($requestedResults.value)
}

$sortedResults = $results | Sort-Object -Property finishTime -Descending

if ($q)
{
    $selectedBuild = $sortedResults[0]
}
else 
{
    
    Write-Host 
    Write-Host "========================"
    Write-Host 
    $counter = 0
    
    foreach ($res in $sortedResults)
    {
        $counter++
        Write-Host "    $counter. $($res.buildNumber) ($($res.dropLocation))"
        
        if ($counter -ge $maxBuilds)
        {
            break
        }
        
        # much more verbose output:
        # Write-Host "    $counter. $($res.buildNumber)"
        # Write-Host "            Completed:  $($res.finishTime)"
        # Write-Host "            Quality:    $($res.quality)"
        # Write-Host "            Drop:       $($res.dropLocation)"
        # Write-Host "            By:         $($res.lastChangedBy.displayName)"
        # Write-Host
    }
    
    Write-Host 
    Write-Host "========================"
    Write-Host 
    
    $typeQuery = 0
    do
    {
        $typeQuery = $([int]$(Read-Host "Pull build (1 is latest)")) -1
    } 
    until ($typeQuery -lt $($maxBuilds) -and $typeQuery -ge 0)
    
    $selectedBuild = $sortedResults[$typeQuery]
}

$selectedBuild
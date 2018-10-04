# ============================================================================================

# Inputs

# use full path from the root to your branch
$branch = "Main"
#$branch = "Labs\Install\Decoupling"

# use FQN
$drop = "\\SA-BUILD01-V.k2workflow.com\Builds\Main\Main_20181004.4"

# enter K2 user and pass
$user = "K2workflow\whatever"
$pass = "MY PASSWORD HERE"

# ============================================================================================









# ============================================================================================

# Constants

$current = (Get-Item -Path ".\").FullName

$branchRoot = "$/K2 2014"
$fullBranch = "$branchRoot/$branch"

$uid = [guid]::NewGuid()
$workspaceName = "Prep_$uid"
$workspaceDir = "$current\$uid\"

mkdir $workspaceDir
Set-Location $workspaceDir

$collection = "https://tfs.k2.com/tfs/Labs"

$tf = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer\TF.exe"

if (!(Test-Path $tf))
{
    $tf = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer\TF.exe"
}

if (!(Test-Path $tf))
{
    $tf = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\TF.exe"
}

# ============================================================================================


# ============================================================================================

# get branch

& $tf vc workspace /new /noprompt $workspaceName /server:$collection /login:$user,$pass
& $tf get "$fullBranch/Common" /recursive 
& $tf get "$fullBranch/Build" /recursive
& $tf get "$fullBranch/Install" /recursive
& $tf get "$fullBranch/Build Output/Assemblies/Install/" /recursive
& $tf get "$fullBranch/Build Output/Assemblies/External/" /recursive
& $tf get "$fullBranch/Build Output/Assemblies/x86/Program Files/K2/Bin" 
& $tf get "$fullBranch/Build Output/Assemblies/x86/Program Files/K2/Host Server/Bin" 

# ============================================================================================


# ============================================================================================

# update build output from build

net use x: $drop /user:$user $pass

$mergeFile = "x:\FileMerge.list"
$buildOutput = "K2 2014\$branch\Build Output\"

foreach ($file in (Get-Content $mergeFile))
{
    $parts = $file.Split('>')

    $source = $parts[0].Replace("[SOURCE]", "$drop\")
    $target = $parts[1].Replace("[DESTINATION]", "$buildOutput\") + "\"
    $target = "$workspaceDir\$target"

    # only update existing
    if (Test-Path $target)
    {
        xcopy /Y /R /F /I $source $target
    }
    else 
    {
        Write-Host $target "does not exist"    
    }

}

# ============================================================================================


# ============================================================================================

# cleanup

Set-Location $current

& $tf vc workspace /delete $workspaceName /server:$collection /login:$user,$pass
net use x: /delete

# ============================================================================================


# ============================================================================================

# start solution in new workspace

& "$workspaceDir\K2 2014\$branch\Install\Install Core.sln"

# ============================================================================================
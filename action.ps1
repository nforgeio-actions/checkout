#------------------------------------------------------------------------------
# FILE:         action.ps1
# CONTRIBUTOR:  Jeff Lill
# COPYRIGHT:    Copyright (c) 2005-2021 by neonFORGE LLC.  All rights reserved.
#
# The contents of this repository are for private use by neonFORGE, LLC. and may not be
# divulged or used for any purpose by other organizations or individuals without a
# formal written and signed agreement with neonFORGE, LLC.

# Verify that we're running on a properly configured neonFORGE jobrunner 
# and import the deployment and action scripts from neonCLOUD.
      
# NOTE: This assumes that the required [$NC_ROOT/Powershell/*.ps1] files
#       in the current clone of the repo on the runner are up-to-date
#       enough to be able to obtain secrets and use GitHub Action functions.
#       If this is not the case, you'll have to manually pull the repo 
#       first on the runner.
      
$ncRoot = $env:NC_ROOT
      
if (![System.IO.Directory]::Exists($ncRoot))
{
    throw "Runner Config: neonCLOUD repo is not present."
}
      
$ncPowershell = [System.IO.Path]::Combine($ncRoot, "Powershell")
      
Push-Location $ncPowershell
. ./includes.ps1
Pop-Location
      
# Checks out the named repo, resetting it first to clear
# any uncommitted changes.

function Checkout
{
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=1)]
        [string]$repoName
    )
          
    $repoPath = "$env:NF_REPOS\$repoName"
          
    Write-Output ""
    Write-Output "Checkout: $repoPath"
            
    Push-Location $repoPath
          
    git reset --quiet --hard
    git checkout --quiet "$env:branch"
    git pull --quiet
          
    Pop-Location
}
        
# Checkout the repos
        
Checkout neonCLOUD
Checkout neonKUBE
Checkout neonLIBRARY
Checkout nforgeio.github.io
Checkout cadence-samples
Checkout temporal-samples

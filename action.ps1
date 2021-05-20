#Requires -Version 7.0 -RunAsAdministrator
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
      
if ([System.String]::IsNullOrEmpty($ncRoot) -or ![System.IO.Directory]::Exists($ncRoot))
{
    throw "Runner Config: neonCLOUD repo is not present."
}
      
$ncPowershell = [System.IO.Path]::Combine($ncRoot, "Powershell")
      
Push-Location $ncPowershell
. ./includes.ps1
Pop-Location
      
# Checks out the named repo and branch, resetting it first to clear
# any uncommitted changes.

function Checkout
{
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$repoName,
        [Parameter(Position=1, Mandatory=$false)]
        [string]$repoBranch = "master"
    )
          
    $repoPath = "$env:NF_REPOS\$repoName"
          
    Write-Output "check-out: $repoPath"
            
    Push-Cwd $repoPath
          
        git reset --quiet --hard
        ThrowOnExitCode

        git checkout --quiet "$repoBranch"
        ThrowOnExitCode

        git fetch --quiet
        ThrowOnExitCode

        git pull --quiet
        ThrowOnExitCode
          
    Pop-Cwd
}
      
# Resets the named repo by clearing any pending changes and then
# checking out and pulling the master branch.

function Reset
{
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$repoName
    )
          
    $repoPath = "$env:NF_REPOS\$repoName"
          
    Write-Output "reset: $repoPath"
            
    Push-Cwd $repoPath
          
        git reset --quiet --hard
        ThrowOnExitCode
    
        git fetch --quiet
        ThrowOnExitCode

        git checkout --quiet master
        ThrowOnExitCode
    
        git pull --quiet
        ThrowOnExitCode
          
    Pop-Cwd
}

# Read the inputs.

$branch                  = Get-ActionInput "branch" $true
$skip_neonCLOUD          = Get-ActionInputBool "skip-neoncloud"
$skip_neonKUBE           = Get-ActionInputBool "skip-neonkube"
$skip_neonLIBRARY        = Get-ActionInputBool "skip-neonlibrary"
$skip_nforgeio_github_io = Get-ActionInputBool "skip-nforgeio-github-io"
$skip_cadence_samples    = Get-ActionInputBool "skip-cadence-samples"
$skip_temporal_samples   = Get-ActionInputBool "skip-temporal-samples"
$reset                   = Get-ActionInputBool "reset"

# Perform the operation

try
{
    # Special case reset mode

    if ($reset)
    {
        Reset "neonCLOUD"
        Reset "neonKUBE"
        Reset "neonLIBRARY"
        Reset "nforgeio.github.io"
        Reset "cadence-samples"
        Reset "temporal-samples"
        return;
    }
        
    # Checkout the repos

    if (!$skip_neonCLOUD)
    {
        Checkout "neonCLOUD" "$branch"
    }

    if (!$skip_neonKUBE)
    {
        Checkout "neonKUBE"
    }

    if (!$skip_neonLIBRARY)
    {
        Checkout "neonLIBRARY" "$branch"
    }

    # These repos don't have branches other than master so we
    # won't pass the branch input value.

    if (!$skip_nforgeio_github_io)
    {
        Checkout "nforgeio.github.io"
    }
      
    if (!$skip_cadence_samples)
    {
        Checkout "cadence-samples"
    }

    if (!$skip_temporal_samples)
    {
        Checkout "temporal-samples"
    }
}
catch
{
    Write-ActionException $_
}

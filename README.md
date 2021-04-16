# neon-checkout

**INTERNAL USE ONLY:** This GitHub action is not intended for general use.  The only reason why this repo is public is because GitHub requires it.

GitHub Action that checks out nforgeio related repos on JOBRUNNER servers and then pulls any changes.

This action currently pulls these repositories:

* forgeio/cadence-samples
* nforgeio/neonLIBRARY
* nforgeio/neonCLOUD
* nforgeio/neonKUBE
* nforgeio/nforgeio.github.io
* nforgeio/temporal-samples

Note that any uncommitted changes to the repos will be reset first and that the repos will be located within the **NF_REPOS** (`C:\src`) by default.

This action solves a chicken-and-the-egg issue we have where most of the actions we use are embedded in the target repos so we'll need a way to first pull the repos to the JOBRUNNER to obtain the current versions.  We could have used a public action like **actions/checkout** for this but our execution environment is a bit non-standard.

## Local Repository Actions

This action also makes copies of the following repo GitHub action files into the GitHub runner's workspace so they can be referenced by workflows.  The GitHub action **uses** syntax assumes that all repos are checked out within the runner workspace does not allow action references to anywhere outside of thw working directory (such as our local repos).

**neonCLOUD:** Actions will be copied to **github.workspace/actions/neonCLOUD** and a file like **my-action.yaml** can be referenced like:
```
./actions/neonCLOUD/my-action.yaml
```

## Examples

**Pull the (default) master branches for all repos:**
```
- uses: nforgeio-actions/neon-checkout
```

**Pull the "features" branch for all repos:**
```
- uses: nforgeio-actions/neon-checkout
  with:
    branch: features
```


## Implementation Note

This action assumes that it's being run on a specially configured self-hosted (Windows) jobrunner with the relevant neonFORGE repos already cloned to specific directories.  Generic jobrunners are not supported.

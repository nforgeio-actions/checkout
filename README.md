# checkout

**INTERNAL USE ONLY:** This GitHub action is not intended for general use.  The only reason why this repo is public is because GitHub requires it.

GitHub Action that checks out nforgeio related repos on JOBRUNNER servers and then pulls any changes.

This action currently pulls these repositories:

* forgeio/cadence-samples
* nforgeio/neonLIBRARY
* nforgeio/neonCLOUD
* nforgeio/neonKUBE
* nforgeio/nforgeio.github.io
* nforgeio/temporal-samples

Note that any uncommitted changes to the repos will be reset first and that the repos will be located within the **NF_REPOS** (`C:\src`).

## Examples

**Pull the (default) master branches for all repos:**
```
- uses: nforgeio-actions/checkout
```

**Pull the "features" branch for all repos:**
```
- uses: nforgeio-actions/checkout
  with:
    branch: features
```


## Implementation Note

This action assumes that it's being run on a specially configured self-hosted (Windows) jobrunner with the relevant neonFORGE repos already cloned to specific directories.  Generic jobrunners are not supported.

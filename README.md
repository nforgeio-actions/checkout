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

## Examples

**Pull the (default) master branches for all repos:**
```
- uses: nforgeio-actions/neon-checkout
```

**Pull the features branch for all repos:**
```
- uses: nforgeio-actions/neon-checkout
  with:
    branch: features
```

**Pull the features branch for all repos to a custom directory:**
```
- uses: nforgeio-actions/neon-checkout
  with:
    branch: features
    folder: C:\Temp\test-folder
```

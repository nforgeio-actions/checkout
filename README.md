# neon-checkout
GitHub Action that checks out nforgeio related repos on JOBRUNNER servers and then pulls any changes.

This action currently pulls these repositories:

* forgeio/cadence-samples
* nforgeio/neonLIBRARY
* nforgeio/neonCLOUD
* nforgeio/neonKUBE
* nforgeio/nforgeio.github.io
* nforgeio/temporal-samples

Note that any uncommitted changes to the repos will be reset first.

## Example

Pull the **master** branches for all repos:
```
- uses: nforgeio-actions/neon-checkout
```

Pull the **features** branch for all repos:
```
- uses: nforgeio-actions/neon-checkout
  with:
    branch: features
```

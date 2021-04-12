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

This action solves a chicken-and-the-egg issue we have where most of the actions we use are embedded in the target repos so we'll need a way to first pull the repos to the JOBRUNNER to obtain the current versions.  We could have used a public action like **actions/checkout** for this but our execution environment is a bit non-standard.

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

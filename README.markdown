# Boot libraries for GHCJS

This repository contains the libraries that `ghcjs-boot` builds and
a few additional files that are used in the boot process. A snapshot
of this repository is included with a release distribution of GHCJS
(in `lib/cache/boot.tar`).

`ghcjs-boot --dev` clones this repository in the GHCJS library directory.
The default location is something like
`~/.ghcjs/x86_64-darwin-0.1.0-7.8.3/ghcjs/ghcjs-boot`, but you can change
the library directory by editing the GHCJS wrapper script (change the `-B`
argument).

The runtime system is not included in this repository, it's in the
shims repo (also cloned by `ghcjs-boot`, default location similar to
`~/.ghcjs/x86_64-darwin-0.1.0-7.8.3/ghcjs/shims`).

`ghcjs-boot` does not try to update an existing `ghcjs-boot` repository,
use `ghcjs-boot --dev --clean` to start from scratch. This completely
removes any existing version.

## Developing the libraries

All libraries are included as git submodules. Most of them directly refer
to the upstream repository, since maintaining our own fork is rather
heavyweight and most packages can be used unchanged or almost unchanged.

`ghcjs-boot` applies the patches under
`/patches` after initializing the submodules when the repository is first
cloned. After that, you're on your own, `ghcjs-boot` does not try to
re-apply updated patches.

to update a patched submodule:

    $ git reset --hard
    $ git checkout branch
    $ git pull
    $ patch -p1 < ../../patches/package.patch

    now fix any issues with the patch. to quickly get a new patch without
    making a commit, add all untracked files using `git add -N`, and then:

    $ git diff > ../../patches/package.patch

    and add the changes to the commit (from the root of the repository):

    $ git add patches/package.patch
    $ git add boot/package

## Preparing a release

run `cabal sdist` in the ghcjs repository, this runs the `utils/update_archives.sh`
script that clones the ghcjs-boot repository to build the
`lib/cache/boot.tar` file. It also builds `lib/cache/shims.tar` (from the shims
repository) and `lib/cache/test.tar` (from the test subdirectory).

Verify that a fresh release boot (`ghcjs-boot --clean`, without `--dev`) finishes
without errors and that all tests in the test suite pass. Install the standalone
`ghcjs-testsuite` package from the `test` subdirectory to easily validate the release:
`ghcjs-testsuite` automatically runs the tests from the library directory of
a GHCJS release build.

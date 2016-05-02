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

All libraries are included as git submodules. The submodules either point to a
fork of ours or the upstream repository if the library can be used as-is. Our
forks have branches that share names with the the GHCJS branch name that uses
them. The forks' branches should never be forced-pushed, even if upstream's
branches are forced-pushed, so that older GHCJS's submodules still work.

### Fork cheatsheet

See `docs/git-demo.png` for a valid (hypothetical) fork of ours with these
guidelines in action.

 - **Add upstream remote**:
   ```sh
   $ git remote add upstream <URL>
   ```
   Unfortunately the submodule can not be made to keep track of this extra
   remote.

 - **Use newer version of upstream**:
   ```sh
   $ git merge <upstream-tagged-release>
   ```
   If upstream doesn't tag their releases, shame on them! Try comparing the
   Hackage release tarball with their repo to find the right commit.

 - **Change patch (nothing to do with upstream)**:
   ```sh
   # make changes
   $ git commit
   ```
   Just like normal.

 - **Tag for GHCJS release**:
   ```sh
   $ git tag ghcjs-<version>
   ```
   Local tags and tags from remotes all live in the same namespace, hence we use
   the `ghcjs-` prefix to distinugish our releases from upstream's.


 - **Clean up history for PR**:
   ```sh
   $ git checkout -b pull-request-for-upstream
   $ git rebase -i upstream/master
   ```
   Do this only in the case that our merge history makes for an unreadable diff.
   Merge with upstream after PR is merged just like one was merging an upstream
   release.

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

# Test-Commit-Sign

Scratch repository used to validate the **signed commit → SSH push → signature verification** flow with SourceGit.

## What this repository tests

| Step | Check |
| --- | --- |
| 1 | Commits are signed with the OC15 GPG key (`commit.gpgsign = true`) |
| 2 | Push authenticates with the work SSH identity (`github-work` → `yandrisOC15`) |
| 3 | The signature verifies locally and on GitHub |

## Verify locally

```bash
git log --show-signature --format='%h | %G? | %GS | %ae | %s' -3
git verify-commit HEAD
git tag -v v0.1.0
./scripts/verify-signature.sh
```

Expected result: `%G?` reports `G` (good signature) and the signer is
`Yandris Rivera Torres <yrivera@oc15.com>`.

## Signed objects

- `v0.1.0` — signed tag

## Notes

This repository is public; internal documentation stays local and is excluded via `.git/info/exclude`.

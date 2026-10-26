#!/usr/bin/env bash
# Verifies the GPG signature of HEAD and of the v0.1.0 tag.
set -euo pipefail

fail=0

check_commit() {
  local ref="$1" status signer
  status=$(git log -1 --format='%G?' "$ref")
  signer=$(git log -1 --format='%GS' "$ref")
  if [ "$status" = "G" ]; then
    printf 'OK    %-10s good signature (%s)\n' "$ref" "$signer"
  else
    printf 'FAIL  %-10s signature status=%s (%s)\n' "$ref" "$status" "$signer"
    fail=1
  fi
}

check_tag() {
  local tag="$1" output
  if output=$(LC_ALL=C git tag -v "$tag" 2>&1) && printf '%s' "$output" | grep -q 'Good signature'; then
    printf 'OK    %-10s good signature\n' "$tag"
  else
    printf 'FAIL  %-10s %s\n' "$tag" "$(printf '%s' "$output" | tail -n 1)"
    fail=1
  fi
}

check_commit HEAD
check_tag v0.1.0

exit "$fail"

#!/bin/bash
# SPDX-License-Identifier: MIT OR GPL-3.0-or-later

set -eux -o pipefail

cd "$(dirname "$0")/.."

git ls-files "*.sh" | xargs shellcheck
git ls-files "*.py" "*.pyi" | xargs uv run ruff check
git ls-files "*.py" "*.pyi" | xargs uv run codespell
git ls-files "*.sh" | xargs shfmt -d -s
git ls-files "*/Dockerfile" "*.dockerfile" | xargs hadolint
deno lint
deno task pyright
deno task vrm-validator

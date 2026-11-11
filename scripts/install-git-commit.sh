#!/usr/bin/env bash
# Installs the unnamespaced /git-commit command for Qoder CLI.
# Plugin commands are always namespaced (git-skills:commit), so /git-commit has
# to come from the user-level commands directory.
set -euo pipefail

TARGET_DIR="${QODER_CONFIG_DIR:-$HOME/.qoder}/commands"
TARGET_FILE="$TARGET_DIR/git-commit.md"
MARKER="installed by git-skills/scripts/install-git-commit.sh"
FORCE=0

usage() {
  cat <<'EOF'
Usage: install-git-commit.sh [--force] [--help]

Writes ~/.qoder/commands/git-commit.md so the /git-commit slash command is
available in every project. Re-run after upgrading the plugin to refresh it.

  --force  Overwrite an existing git-commit.md, including one you wrote.
  --help   Show this help.

Uninstall: rm ~/.qoder/commands/git-commit.md
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --force) FORCE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
  esac
  shift
done

if [ -f "$TARGET_FILE" ] && ! grep -qF "$MARKER" "$TARGET_FILE" && [ "$FORCE" -eq 0 ]; then
  echo "Refusing to overwrite $TARGET_FILE (not managed by this script)." >&2
  echo "Re-run with --force to replace it." >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"
TMP_FILE="$(mktemp "${TMPDIR:-/tmp}/git-commit.md.XXXXXX")"
trap 'rm -f "$TMP_FILE"' EXIT

cat > "$TMP_FILE" <<'EOF'
---
name: git-commit
description: Commit current changes with detailed English Conventional Commits, auto-splitting unrelated changes and stripping AI signatures
argument-hint: "[optional overrides: extra context, language, scope, 'single commit', 'dry run']"
---

# Smart Commit

Activate the `git-skills` skill (`/git-skills:git`) and follow its Smart Commit workflow. This command is the unnamespaced equivalent of `/git-skills:commit`.

Apply these defaults unless the overrides at the end say otherwise:

- **English** subject and body, even when the conversation is in another language.
- **Conventional Commits** with a detailed, multi-paragraph body (at least two paragraphs) covering what changed, why, key details and trade-offs. Subject imperative, specific, max 50 characters, no trailing period.
- **Atomic**: split unrelated concerns into separate commits automatically; keep an implementation with its tests.
- **No attribution**: never add `Co-Authored-By:`, "Generated with/by", AI tool names, links or emoji signatures. Strip any attribution injected by tooling before committing. Footers carry only real issue references or breaking-change notices.
- **Commit, don't ask**: execute the commits in this turn instead of only proposing messages. Do not push.
- **Safety**: never stage secrets (`.env`, keys, tokens, credentials) or files over 10 MB; stop and warn if found.

Workflow: inspect `git status --short`, `git diff`, `git diff --cached` and `git log -5 --oneline`; stop if the worktree is clean; plan the split; stage each group with explicit paths (never `git add -A`); commit with the cleaned message; fix pre-commit hook failures at the root instead of using `--no-verify`; verify each commit with `git log -1 --format=%B`; then report the resulting hashes, subjects and how the changes were grouped.

Overrides are natural language: `dry run` presents the planned groups without committing, `single commit` disables splitting, a language request switches the message language, anything else is extra context or scope guidance.

$ARGUMENTS

installed by git-skills/scripts/install-git-commit.sh
EOF

mv "$TMP_FILE" "$TARGET_FILE"
trap - EXIT
chmod 644 "$TARGET_FILE"
echo "Installed /git-commit -> $TARGET_FILE"
echo "Run /commands in a live session (or restart Qoder) to reload commands."

# 🌿 Git Skills

A powerful Claude Code Git assistant skill that provides intelligent branch management, commit message conventions, workflow assistance, and code review guidance.

## Features

| Feature | Description |
|---------|-------------|
| 🌱 **Smart Branch Management** | Auto-suggest branch naming conventions, quick create/switch/cleanup branches |
| ✍️ **Expert Commit Assistant** | Generate detailed, professional commit messages following Conventional Commits |
| 🔄 **PR Workflow Assistant** | PR creation checklist, auto-sync main branch, conflict resolution guidance |
| 🔍 **Code Review Assistant** | Check change scope, sensitive data, commit message quality |
| 📊 **Git Statistics** | Contribution stats, commit history, line change metrics |

## Installation

### Claude Code

```bash
/plugin marketplace add lispking/git-skills
/plugin install git-skills
```

### Qoder CLI

```bash
qoder plugins install /path/to/git-skills   # or: qoder plugins marketplace add lispking/git-skills
```

Restart Qoder or run `/plugins reload` to load the plugin.

Qoder always namespaces plugin components, so the plugin command is `/git-skills:commit`. To also get the shorter `/git-commit` in every project, run the bundled installer once. It writes a thin user-level command that delegates to this skill:

```bash
bash scripts/install-git-commit.sh   # writes ~/.qoder/commands/git-commit.md
```

Then run `/commands` (or restart) to reload commands. Re-run with `--force` after upgrading to refresh the file; uninstall with `rm ~/.qoder/commands/git-commit.md`.

## Usage

### Slash Command (Recommended)

```
/git-commit
```

or, without running the installer, the plugin's namespaced form:

```
/git-skills:commit
```

Either command applies the defaults that would otherwise need a long prompt:

- Detailed **English** Conventional Commits with multi-paragraph bodies
- **Auto-splits** unrelated changes into atomic commits
- **No AI signatures** or `Co-Authored-By` lines
- Commits immediately instead of only suggesting messages

Add optional hints after the command to override any default:

```
/git-commit scope: auth, include issue #123
/git-commit keep as one commit
/git-commit write messages in Chinese
/git-commit dry run
```

> Claude Code and Qoder both namespace plugin commands as `/git-skills:commit`; `/git-commit` exists only after running `scripts/install-git-commit.sh` (Qoder) or when your client exposes unnamespaced commands.

### Auto-trigger

Git Skills activates automatically when these operations are detected:
- `git commit` - Smart commit suggestions
- `git push` - Pre-push checks
- `git checkout -b` - Branch naming suggestions
- `git merge` / `git rebase` - Conflict resolution guidance

### Natural Language

Tell Claude what you want to do:

```
Help me commit these changes
Create a feature branch for user authentication
Sync my branch with main
Show recent commit statistics
```

## Commit Convention

### Commit Types

| Type | Description | Example |
|------|-------------|---------|
| `feat` | New feature | `feat: implement JWT-based user authentication` |
| `fix` | Bug fix | `fix: resolve race condition in concurrent database writes` |
| `docs` | Documentation | `docs: add comprehensive API usage examples` |
| `style` | Code style | `style: enforce consistent import ordering across modules` |
| `refactor` | Refactoring | `refactor: decouple business logic from presentation layer` |
| `test` | Tests | `test: add integration tests for payment gateway` |
| `chore` | Build/tools | `chore: migrate build pipeline from CircleCI to GitHub Actions` |
| `perf` | Performance | `perf: implement connection pooling for database queries` |
| `ci` | CI/CD | `ci: add automated security scanning to pipeline` |

### Commit Format

```
<type>(<scope>): <subject>

<body paragraph 1: what changed and why>

<body paragraph 2: implementation details, considerations>

<footer>
```

**Expert-level requirements:**
- Subject: specific, imperative mood, max 50 chars, no period
- Language: **English by default** (override per request or in `.gitskills.json`)
- Splitting: **unrelated changes are committed separately** by default
- Body: **mandatory multi-paragraph** for all non-trivial changes
  - Paragraph 1: explain WHAT changed and WHY (motivation)
  - Paragraph 2: key implementation details, trade-offs, breaking changes
  - Use blank lines to separate paragraphs
- Include: problem context, approach rationale, side effects, breaking changes
- Footer: issue references, breaking change notices
- **NO** `Co-Authored-By:` signatures
- **NO** AI-generated signatures
- **NO** single-sentence commit messages

## Branch Naming Convention

```
feature/123-user-auth      # New features
bugfix/456-fix-login       # Bug fixes
hotfix/urgent-patch        # Critical fixes
refactor/api-cleanup       # Code refactoring
docs/readme-update         # Documentation
test/auth-tests            # Test-related
```

## Configuration

Create `.gitskills.json` in project root:

```json
{
  "commit": {
    "types": ["feat", "fix", "docs", "style", "refactor", "test", "chore"],
    "scopes": ["api", "ui", "auth", "db"],
    "requireScope": false,
    "requireBody": true,
    "language": "en",
    "autoSplit": true
  },
  "branch": {
    "mainBranch": "main",
    "namingPattern": "{type}/{ticket-id}-{description}"
  }
}
```

## Project Structure

```
git-skills/
├── .claude-plugin/
│   ├── plugin.json       # Plugin config (supports /plugin install)
│   └── marketplace.json  # Marketplace display config
├── commands/
│   └── commit.md         # /git-skills:commit slash command
├── skills/
│   └── git/
│       └── SKILL.md      # Skill core documentation (official spec)
├── scripts/
│   └── install-git-commit.sh  # Installs the unnamespaced /git-commit command
├── .gitskills.json       # Configuration example
└── README.md             # User documentation
```

## License

MIT License

## Contributing

Issues and PRs welcome!

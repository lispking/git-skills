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

In Claude Code, run:

```bash
/plugin marketplace add lispking/git-skills
/plugin install git-skills
```

## Usage

### Auto-trigger

Git Skills activates automatically when these operations are detected:
- `git commit` - Smart commit suggestions
- `git push` - Pre-push checks
- `git checkout -b` - Branch naming suggestions
- `git merge` / `git rebase` - Conflict resolution guidance

### Command Invocation

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

<body>

<footer>
```

**Expert-level requirements:**
- Subject: specific, imperative mood, max 50 chars, no period
- Body: **mandatory** for non-trivial changes, explains WHAT and WHY
- Include: problem context, approach rationale, side effects, breaking changes
- Footer: issue references, breaking change notices
- **NO** `Co-Authored-By:` signatures
- **NO** AI-generated signatures

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
    "requireBody": true
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
├── skills/
│   └── git/
│       └── SKILL.md      # Skill core documentation (official spec)
├── .gitskills.json       # Configuration example
└── README.md             # User documentation
```

## License

MIT License

## Contributing

Issues and PRs welcome!

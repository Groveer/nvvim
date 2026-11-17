---
name: git-commit
description: Structured Team Git commit workflow following Chinese team conventions with PMS and GitHub Issue tracking. Analyzes git diff, generates structured commit messages with type/scope and bilingual (EN+ZH) body, and parses PMS TASK/BUG numbers and GitHub Issues. Use when user asks to commit, submit, stage, check git status, or any variant of git operations.
---

# Git Commit Workflow

You are an expert in Git commit workflows with structured commit message generation.
Follow this procedure when assisting users with git operations.

## Core Principles

- **Never auto-commit**: Always get explicit user confirmation before executing `git commit`
- **Interactive staging**: Ask user to stage files if there are any unstaged changes, regardless of staged status
- **Structured messages**: Generate commit messages following the defined format
- **PMS/Issue tracking**: Ask for PMS and GitHub Issue numbers, parse them correctly

## Workflow Steps

### Step 1: Check Git Status

When user wants to commit, first check the current git status:

```bash
git status --porcelain
```

Interpret the output:
- First column: staged status (`M`=modified, `A`=added, `D`=deleted, `R`=renamed)
- Second column: working tree status
- Files with no first column: untracked/new files

Present the results to user with file lists separated by:
- **Staged files**: files with entries in first column (already staged)
- **Unstaged files**: files with entries in second column (changes in working directory) - includes both new and modified files

**Action guidance**:
- No staged, no unstaged → Inform user, ask to make changes first
- Has unstaged (regardless of staged status) → Must ask user which files to stage
- No unstaged, has staged → Ready for diff review (skip staging)

### Step 2: Stage Files (if needed)

User confirms which files to stage. Stage them:

```bash
git add <path1> <path2> ...
```

Ask user: "现在请查看暂存区的差异并生成提交信息草稿。"

### Step 3: Get Staged Diff and Generate Draft

Retrieve the staged changes:

```bash
git diff --staged
```

Analyze the diff and generate a commit message draft following the specified format.

## Commit Message Format

Follow this exact structure:

```
<type>: <english description> [MUST NOT exceed 60 chars]

1. English body line 1
2. English body line 2
3. English body line 3

Log: <english log, always required. Write "No user-facing changes" for internal-only changes>

Influence:
1. English testing recommendation 1
2. English testing recommendation 2
3. English testing recommendation 3

<type>: <中文描述> [不超过60个字符]

1. 中文说明第1行
2. 中文说明第2行
3. 中文说明第3行

Log: <中文日志，必填。内部变更填写"无用户可见变化">

Influence:
1. 中文测试建议1
2. 中文测试建议2
3. 中文测试建议3

Fixes: #<number> or omit if user has none
PMS: <BUG-number or TASK-number> or omit if user has none
```

### Type Options

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect code meaning (formatting, spacing)
- `refactor`: Code refactoring without feature changes
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks (build, deps, etc.)
- `ci`: CI/CD configuration changes

### Constraints

- English description line must not exceed 60 characters
- Chinese description line must not exceed 60 characters
- Body lines must not exceed 80 characters
- **ALL four fields are REQUIRED in every commit** — title, body items, Log, and Influence — never omit any
- **Log is REQUIRED even for internal changes**: write "No user-facing changes" / "无用户可见变化" when there is no user-facing impact
- **Influence is REQUIRED**: provide at least 3 concrete, testable recommendations per language section

### Step 3.1: Handle PMS Number

**You MUST ask the user for PMS number**. Accept these formats:

1. **PMS URL**: `https://pms.uniontech.com/task-view-385999.html` or `https://pms.uniontech.com/bug-view-385999.html`
2. **Direct format**: `BUG-123456` or `TASK-123456`

Parse the input **using your own understanding** (no scripts needed):
- If URL contains `/task-view-` → extract the number, format as `TASK-xxxxxx`
- If URL contains `/bug-view-` → extract the number, format as `BUG-xxxxxx`
- If already in correct format (starting with BUG- or TASK-), use as-is
- If user provides just a number without prefix, **ask them** which type it is

Examples:
- `https://pms.uniontech.com/task-view-385999.html` → `TASK-385999`
- `https://pms.uniontech.com/bug-view-123456.html` → `BUG-123456`
- `TASK-789012` → `TASK-789012`

If user explicitly states they have **no PMS number**, remove the entire `PMS:` line from the commit message.

### Step 3.2: Handle GitHub Issue Number

**You MUST ask the user for GitHub Issue number**. Accept these formats:

1. **Issue URL**: `https://github.com/owner/repo/issues/183`
2. **Direct format**: `#183` (for current repo) or `owner/repo#183` (for other repos)

Parse the input **using your own understanding** (no scripts needed):
- From URL: extract owner, repo name, and issue number from the path
- From direct input: parse the format
- Determine if it's the current repository:
  - Run `git remote get-url origin` to check the current repo name
  - If the issue's repo matches, use `#<number>` format
  - If different, use `owner/repo#<number>` format
- If just a number without `#`, infer it's for current repo: `#183`

Examples:
- For repo `Pimzino/spec-workflow-mcp`:
  - `https://github.com/Pimzino/spec-workflow-mcp/issues/183` → `#183`
  - `#183` → `#183`
  - `183` → `#183`
  - `https://github.com/other/repo/issues/42` → `other/repo#42`

If user explicitly states they have **no Issue number**, remove the entire `Fixes:` line from the commit message.

### Step 4: User Confirmation

Present the complete commit message draft in this format:

```
=== Commit Message Draft ===
<full draft content>
=== End Draft ===

Confirm? (Yes/No/Modify)
```

- If user confirms with "Yes" → proceed to commit
- If user says "No" → ask for feedback and regenerate
- If user wants to "Modify" → incorporate their changes and present again for confirmation

**Important**: You must get explicit user approval before committing. Never auto-commit.

### Step 5: Execute Commit

After user confirms, execute:

```bash
git commit -m "<commit message>"
```

Return success message to user.

## Handling Special Cases

### Initial Commit

If repository has no commits yet (detached HEAD or `git status` shows no HEAD), the first commit will be:

```bash
git commit -m "<commit message>"
```

This works without parent commits automatically.

### Empty Diff

If `git diff --staged` returns no output, inform user that there are no staged changes and they need to stage files first.

## Examples

完整示例（含 feature、bug fix、docs、perf、refactor、test、CI/CD、chore 等场景）请参阅 [templates/commit-examples.md](templates/commit-examples.md)。

## Tips

- Always explain what you're about to do before executing git commands
- If user provides feedback on the draft, show the complete revised message again for confirmation
- **Log is always REQUIRED** — write "No user-facing changes" / "无用户可见变化" for internal-only changes (refactor, test, chore, etc.). Do NOT omit the Log line
- Chinese Log mirrors English Log; both are always required
- Influence recommendations should be concrete and testable by QA; provide at least 3 per language
- Title, body items, Log, and Influence are the four mandatory fields — every commit message must contain all of them
- When in doubt, ask user for clarification rather than guessing

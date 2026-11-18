---
name: git-commit
description: Commit code with structured bilingual (EN+ZH) messages ending in a PMS/Fixes trailer block. Use when user asks to commit, git commit, 提交, 暂存, stage or submit changes.
---

# Git Commit Workflow

IRON LAW: **Every commit message ends with a trailer block. `PMS:` is always present; `Fixes:` joins it when an Issue exists.**
A trailer block is the message's final blank-line-separated paragraph, holding only `Token: value` lines.
With no number, the `PMS:` line still appears — value empty, never dropped, never filled with a placeholder.

## Workflow Checklist

Copy and track progress:

```
Git Commit Progress:

- [ ] Step 1: Check git status ⚠️ REQUIRED
- [ ] Step 2: Stage files (conditional — skip if nothing unstaged)
- [ ] Step 3: Read staged diff ⚠️ REQUIRED
  - [ ] 3.1 Settle the trailer block; default to a bare `PMS:` ⚠️ REQUIRED
  - [ ] 3.2 Verify draft against Constraints ⚠️ REQUIRED
- [ ] Step 4: Present draft for approval ⛔ BLOCKING
- [ ] Step 5: Execute commit ⛔ BLOCKING (re-check the trailer block)
- [ ] Step 6: Verify trailers with interpret-trailers ⚠️ REQUIRED
```

## Step 1: Check Git Status ⚠️ REQUIRED

Run:

```bash
git status --porcelain
```

Read both columns — first is the index, second is the worktree:
- `M` / `A` / `D` / `R` in the first column: a staged change
- `?` in both columns: an untracked file
- `MM`: staged change **plus** further unstaged edits in the same file — do not blanket `git add` it, or the unreviewed edits get committed
- `UU` / `AA` / `DD`: unresolved merge conflict

Before anything else: if any `UU` / `AA` / `DD` entry exists, stop and tell the user to resolve the conflict. A commit attempt at this point fails outright ("Exiting because of an unresolved conflict"), so never start the flow.

Report two lists: **staged files** (first column populated) and **unstaged files** (second column populated, new or modified).

Then branch:
- Nothing staged, nothing unstaged → report and stop; ask the user to make changes first
- Anything unstaged (regardless of staged state) → ask which files to stage, go to Step 2
- Nothing unstaged, something staged → skip Step 2, go to Step 3

## Step 2: Stage Files (conditional)

Skip this step entirely when nothing is unstaged.

Ask which of the unstaged files belong in this commit. Do not infer the set yourself — partial staging is the normal case, and guessing wrong silently commits unrelated work.

Stage exactly the confirmed paths:

```bash
git add <path1> <path2> ...
```

Then continue to Step 3 immediately; no extra confirmation round is needed.

## Step 3: Read Staged Diff ⚠️ REQUIRED

```bash
git diff --staged
```

If the output is empty, stop and report that nothing is staged. Never commit an empty change, and never fall back to `git add -A` to manufacture one.

Analyze the diff, then settle the trailer block in Step 3.1.

### Step 3.1: Settle the Trailer Block ⚠️ REQUIRED

Settle two questions: does `PMS:` carry a value, and is there a `Fixes:` line. Take whatever the user offers — a number never blocks the commit, only the block itself is required.

`PMS:` always appears; `Fixes:` appears only when there is an Issue. Resolution:

**PMS** — accepts a URL or `TASK-<n>` / `BUG-<n>`:
- `.../task-view-<n>.html` → `TASK-<n>`; `.../bug-view-<n>.html` → `BUG-<n>`
- Already prefixed → use as-is
- Bare number → confirm the type when the user is reachable; when nobody can be asked, assume `TASK-<n>` and state the assumption in the final report
- Nothing supplied → emit `PMS:` with an empty value and continue to Step 3.2

**GitHub Issue** — accepts a URL or `#<n>` / `owner/repo#<n>`:
- Resolve the current repo with `git remote get-url origin`; if that fails (no `origin`, exits 2), treat every Issue as local
- Same repo → `#<n>`; other repo → `owner/repo#<n>`; bare number → `#<n>`
- Nothing supplied → omit the `Fixes:` line entirely, do not emit it blank

**Never fabricate** a number, and never infer one from branch names, commit history, issue titles, or the diff. An empty `PMS:` is the correct outcome of having no number — a placeholder like `TASK-000000` is not.

### Step 3.2: Verify Draft ⚠️ REQUIRED

Draft the message using the structure defined in the **Commit Message Format** section below, then check every item. Any failure → rewrite and re-check.

- [ ] English title ≤60 chars
- [ ] Chinese title ≤60 chars
- [ ] Every body line and Influence line ≤80 chars
- [ ] Both language sections have a non-empty `Log:` line
- [ ] Both `Influence:` sections have ≥3 concrete, QA-actionable items (3–5 recommended)
- [ ] A `PMS:` line exists — with a value or empty, never absent
- [ ] `PMS:` value, when non-empty, matches `^(TASK|BUG)-\d+$`
- [ ] `Fixes:`, when present, is `#N` or `owner/repo#N` with a non-empty value
- [ ] No `<...>` placeholder survives in a trailer value
- [ ] The trailer block is the **last** paragraph — at least one blank line above it, nothing after it

## Step 4: Present Draft ⛔ BLOCKING

If Step 3.2 failed, do not reach this step — fix the draft in Step 3.2 instead of showing an invalid one.

```
=== Commit Message Draft ===
<full draft content>
=== End Draft ===

Confirm? (Yes/No/Modify)
```

- "Yes" → Step 5
- "No" → ask what to change, regenerate, show the full revised message again
- "Modify" → apply the edits, show the full revised message again

Never run `git commit` without an explicit "Yes" — the one exception is the unattended mode described below.

## Step 5: Execute Commit ⛔ BLOCKING

Re-read the final message and confirm the trailer block is intact: a `PMS:` line is present (empty value is fine), `Fixes:` is either absent or carries a value, and no blank line splits them. If the block is missing, repair it before committing — an absent trailer block breaks Step 6, a blank `PMS:` does not.

Commit with a heredoc so the body survives shell quoting. A quoted `-m` string is not safe here — titles and bodies routinely contain backticks and `$VAR`, and a double-quoted `-m` lets the shell expand both before git ever sees them. Literal `\n` inside `-m` is also stored as two characters rather than a line break.

```bash
git commit -F - <<'EOF'
<commit message>
EOF
```

A repository with no commits yet needs no special handling — the same form works, and `git diff --staged` still lists the new files in Step 3.

## Step 6: Verify Trailers ⚠️ REQUIRED

Check that the stored message kept its structure:

```bash
git log -1 --pretty=%B
```

The title, body, `Log:`, `Influence:`, and trailer lines must all be present.

Then parse the trailers:

```bash
git show -s --format=%b | git interpret-trailers --parse
```

Use `%b`, not `%B`. `--parse` takes only the message's **last blank-line-separated paragraph** as the candidate block, and a message with no blank line at all yields nothing. `%B` prepends the subject plus a blank line, so a body that is a single paragraph suddenly has a divider in front of it and parses as a trailer block. That is a false positive: `%B` reports success for a message whose body never had a trailer block. `%b` is the body alone — the text the parser should see.

**Exit code is always 0 — never use it as the check.** `--parse` fails by printing nothing or dropping lines, so compare the output yourself:

1. Same number of lines, same labels, in the same order as the block you drafted.
2. Each value matches after git's own trimming of leading and trailing spaces, so `PMS: TASK-1   ` printing as `PMS: TASK-1` is correct.
3. No value still contains `<` or `>` — that means a placeholder was copied out of the format block instead of being replaced.
4. Every printed label that you drafted carries a value, except a deliberately blank `PMS:`.

| Printed output | Meaning |
|---|---|
| Both trailer lines, as drafted | Correct |
| `PMS: ` — alone or above `Fixes:` | Correct — the PMS was intentionally left blank |
| Only the last trailer | Blank line between trailers — remove it |
| Nothing at all | Block is not the last paragraph, has no blank line above it, is indented, uses a full-width colon, or is followed by any text (even a list) |
| A `Log:` or `Influence:` line appears alongside the trailers | The block was not separated from the body, so the parser absorbed the paragraph above it |
| `Fixes: ` with nothing after it | The line was emitted blank — delete the `Fixes:` line and amend |
| A value containing `<` or `>` | A placeholder survived; replace it with the real number or leave `PMS:` empty |

If the comparison fails, fix the message and amend (only when the commit is not yet pushed):

```bash
git commit --amend -F - <<'EOF'
<corrected commit message>
EOF
```

If it is already pushed, report the malformed trailers instead of rewriting shared history — never force-push a fix without the user asking for it.

## Unattended / Automation Mode

When the caller disables interaction (`question` disabled, CI, subagent pipelines):

- Skip Step 2's staging question. Commit only what is already staged; if the index is empty, abort with a report instead of guessing paths.
- Skip Step 4's "Yes/No/Modify" prompt; treat the pre-approved draft as accepted.
- Keep Step 3.1 and Step 6 unchanged. A bare number becomes `TASK-<n>` without asking, and no number still commits with a bare `PMS:` line. State both assumptions in the final report. The trailer block is the gate; the number is not.

## Commit Message Format

Exact structure — English section first, then Chinese, then the trailer block:

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

PMS: <TASK-number or BUG-number>
Fixes: <#number>
```

Replace every `<...>` placeholder before committing. A literal `TASK-number` or `<#number>` in the stored message passes `--parse` but is not a real reference.

Because the block is the last paragraph, everything above it needs at least one blank line of separation — that separation is what `--parse` keys on.

`PMS:` is always present and its value may be empty; write it as a bare `PMS:` with nothing after the colon. Omit the `Fixes:` line entirely when there is no Issue — never emit it blank. A blank `PMS:` on its own is a valid block; `--parse` prints it back as `PMS: `, which is the expected result, not a failure.

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

- Title (both languages) ≤60 characters
- Body and Influence lines ≤80 characters
- Title, body, `Log:`, `Influence:` are all mandatory in both language sections
- `Log:` is mandatory even for internal work — write "No user-facing changes" / "无用户可见变化"
- `Influence:` needs ≥3 concrete, testable items per language; "check it works" is not an item
- A trailer block with `PMS:` (and `Fixes:` when an Issue exists) is mandatory; trailer values are not
- `PMS:` may be empty; when non-empty it must match `^(TASK|BUG)-\d+$`
- `Fixes:` is omitted when there is no Issue — never emitted blank
- Trailers go last, at least one blank line above them, none between them, nothing after them

## Examples

Full worked examples for feat, fix, docs, perf, refactor, test, CI/CD, and chore, plus both blank-`PMS:` forms: see [references/commit-examples.md](references/commit-examples.md). Load it when you need a concrete pattern or the user asks what a message should look like.

## Anti-Patterns

- **Dropping the trailer block** — `PMS:` must be there even with no value; an absent block parses to nothing
- **Fabricating a reference number** — never invent, infer, or use `TASK-000000` / `TASK-TBD`; leave `PMS:` empty instead
- **Omitting a `Fixes:` the user actually provided** — the one trailer you must never drop
- **Auto-committing without an explicit "Yes"** — the approval gate is not optional; only the unattended mode above may skip it
- **`git commit -m "...multi-line..."`** — the shell mangles backticks, `$VAR`, and `\n`; use the heredoc form
- **`git add -A` as a fallback** — never widen the change set the user approved
- **Trusting `interpret-trailers --parse` exit code** — it always returns 0; compare its output instead
- **Reporting success without Step 6** — malformed trailers parse to nothing and go unnoticed
- **Blank line between `PMS:` and `Fixes:`** — the parser then drops everything but the last trailer
- **Copying a `<...>` placeholder into the message** — it parses cleanly and is still not a reference; substitute the real value or leave `PMS:` empty

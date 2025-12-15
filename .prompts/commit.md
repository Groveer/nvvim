---
name: Commit message
interaction: chat
description: Generate a commit message
opts:
    alias: commit
    auto_submit: true
    is_slash_cmd: true
    is_default: true
    user_prompt: true
---

## user

You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
${commit.diff}
```

Commit content should be written in the following format, And use markdown syntax to display:

```text
<type>[optional scope]: <english description>

[English body]

[Chinese body]

Log: [short description of the change use chinese language]
PMS: <BUG-number>(for bugfix) or <TASK-number>(for add feature) (Must include 'BUG-' or 'TASK-', If the user does not provide a number, remove this line.)
Influence: Explain in Chinese the potential impact of this submission.
```

The body line cannot exceed 80 characters.

If the modification scope is small, you can omit both bodies line.
If you do not omit the body, then do not omit any bodies.

Submit information content based on the user's intention below:


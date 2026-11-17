---
name: Commit message(Company)
interaction: chat
description: Generate a commit message
skills: 
  - git-commit
opts:
  alias: commit
  auto_submit: false
  is_slash_cmd: true
---

## user

You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
${commit.diff}
```


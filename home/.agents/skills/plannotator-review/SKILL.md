---
name: plannotator-review
description: Open Plannotator's browser-based code review UI for the current worktree or a pull request URL, then act on the feedback that comes back.
disable-model-invocation: true
---

# Plannotator Review

Use this skill when the user wants to review current code changes in Plannotator instead of reading a diff inline.

Run:

```bash
plannotator review [optional-pr-url]
```

Behavior:

1. Launch the command with Bash.
2. **Do not set a timeout** — the command opens a browser UI and blocks until you finish reviewing. Omit the `timeout` parameter entirely so it waits indefinitely.
3. Wait for it to finish.
4. If it returns feedback or annotations, address them in the same conversation.
5. If it returns an approval/LGTM-style message, acknowledge that review passed and continue.

Do not ask the user to copy shell commands into chat. Run the command yourself.

---
name: plannotator-annotate
description: Open Plannotator's annotation UI for a markdown file, HTML file, URL, or folder and then respond to the returned annotations.
disable-model-invocation: true
---

# Plannotator Annotate

Use this skill when the user wants to annotate a document in Plannotator instead of reviewing it inline in chat.

Run:

```bash
plannotator annotate <path-or-url>
```

Behavior:

1. Launch the command with Bash.
2. **Do not set a timeout** — the command opens a browser UI and blocks until you finish. Omit the `timeout` parameter entirely so it waits indefinitely.
3. Wait for the browser review to finish.
4. If annotations are returned, address them directly.
5. If the session closes without feedback, say so briefly and continue.

Do not ask the user to paste a shell command into the chat. Run the command yourself.

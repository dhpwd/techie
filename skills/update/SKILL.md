---
name: update
description: Check for and install updates to the techie plugin.
disable-model-invocation: true
allowed-tools:
  - Bash
---

# Update techie

Run `claude plugin update techie@dhpwd-techie` via Bash and tell the user the result in plain English. If updated, tell them: "There's a new version. Type `/reload-plugins` to activate it."

If the command fails or isn't recognised, fall back to telling the user: "Type `/plugin update techie@dhpwd-techie` and follow the prompts."

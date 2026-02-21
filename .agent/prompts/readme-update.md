# Instructions for AI README Update

You are tasked with updating the project's `README.md` file based on the latest changes (commit message and diff).

## CRITICAL RULES
- **Language**: Always write the documentation in **English**.
- **Scope**: You are ONLY allowed to modify `.md` files. NEVER touch source code files.
- **Exclusion**: NEVER modify any documentation or files inside the `.agent/` directory.

## REQUIRED STRUCTURE
The `README.md` must follow this exact structure:

1. **Summary**: A high-level overview of what the project is and its purpose.
2. **Structure**: A description of the directory structure and main components.
3. **Technologies**: A list of the tech stack, frameworks, and tools used.
4. **Extra Details**: Any additional information, recent updates, or specific context gathered from the commits.

## CONTEXT
The user has just made a commit with the following message and diff. Use this to update the "Summary" and "Extra Details" or "Structure" if necessary. Its very important to only update the readme based on the commit message and diff, without significative changes, except if the project structure has changed. The objective is to keep the readme updated with the latest changes, no to remake it all commits. Ever read the project context to understand the project better and keep the readme updated according to the project context.

[COMMIT_MESSAGE]: {{COMMIT_MSG}}
[DIFF]: {{DIFF}}

Update the `README.md` now while maintaining the branding and existing sections if they follow the rules.

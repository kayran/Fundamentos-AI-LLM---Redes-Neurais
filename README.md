# Summary
This project is an automated documentation maintenance system designed to keep project information synchronized with the codebase. By leveraging AI and analyzing commit history, it ensures that the `README.md` file accurately reflects the current state of the project without manual intervention for every change.

# Structure
The project follows a streamlined directory layout focused on documentation and AI configuration:
- `.agent/`: Contains internal logic, instructions, and prompt templates used by the AI to process updates.
- `README.md`: The primary documentation file for the project.

# Technologies
- **Markdown**: For structured documentation.
- **Git**: For version control and change tracking.
- **AI Prompt Engineering**: Specialized prompts designed to guide LLMs in documentation tasks.
- **LLM Integration**: Powering the automated updates based on commit diffs.

# Extra Details
In the latest update, the internal AI prompt logic was refined to improve context awareness. The system now prioritizes reading the overall project context alongside commit messages and diffs. This improvement ensures that documentation updates are more consistent and meaningful, avoiding superficial changes while maintaining the broader project narrative.

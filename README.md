# Project Documentation Assistant

## Summary
This project is an automated documentation tool designed to keep `README.md` files synchronized with the latest codebase changes. By analyzing git commit messages and diffs, it ensures that project documentation remains accurate and up-to-date with minimal manual intervention.

## Structure
- **.agent/**: Contains the internal configuration, logic, and prompt templates used by the AI assistant (restricted access).
- **README.md**: The primary documentation file that provides a high-level overview and technical details of the project.

## Technologies
- **Markdown**: For structured and readable documentation.
- **Git**: For version control and tracking changes via commits and diffs.
- **AI Prompt Engineering**: Specialized instruction sets to govern how documentation is generated and updated.

## Extra Details
- **Recent Update**: The AI prompt logic has been refined to ensure that documentation updates are incremental and consistent. The system now prioritizes maintaining the existing structure and only applying changes directly related to the provided commit information, avoiding unnecessary full rewrites.
- **Update Focus**: Current improvements focus on the precision of the documentation agent's responses and its adherence to specific formatting rules.

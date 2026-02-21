#!/bin/bash

# Configuration
PROMPT_FILE=".agent/prompts/readme-update.md"
README_FILE="README.md"
API_KEY=$GEMINI_API_KEY
MODEL="gemini-1.5-flash"

if [ -z "$API_KEY" ]; then
    echo "ERROR: GEMINI_API_KEY environment variable is not set."
    exit 1
fi

# 1. Prevent infinite recursion
LAST_COMMIT_MSG=$(git log -1 --pretty=%B)
if [[ "$LAST_COMMIT_MSG" =~ ^docs\ \(AI\): ]]; then
    echo "SKIPPING: Last commit was an automated AI update. Avoiding recursion."
    exit 0
fi

# 2. Gather context
COMMIT_MSG=$(git log -1 --pretty=%B)
DIFF=$(git show -p HEAD)
INSTRUCTIONS=$(cat "$PROMPT_FILE")

# 3. Preparation instructions for the AI
# We want to ensure it only returns the README content
SYSTEM_INSTRUCTIONS="You are a documentation expert. Based on the commit message and diff provided, update the README.md file. 
Rules: 
- Use English.
- Sections: Summary, Structure, Technologies, Extra Details.
- Never touch source code.
- Never touch .agent folder.
- Return ONLY the raw markdown content for the README.md file."

CLEAN_DIFF=$(echo "$DIFF" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
CLEAN_COMMIT_MSG=$(echo "$COMMIT_MSG" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
CLEAN_INSTRUCTIONS=$(echo "$INSTRUCTIONS" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

# 4. Call Gemini API
echo "Triggering Gemini AI to update README.md..."

PAYLOAD=$(cat <<EOF
{
  "contents": [{
    "parts":[{
      "text": "$SYSTEM_INSTRUCTIONS\n\nInstructions from user:\n$CLEAN_INSTRUCTIONS\n\nCommit Message:\n$CLEAN_COMMIT_MSG\n\nDiff:\n$CLEAN_DIFF"
    }]
  }]
}
EOF
)

RESPONSE=$(curl -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/$MODEL:generateContent?key=$API_KEY" \
    -H "Content-Type: application/json" \
    -d "$PAYLOAD")

AI_CONTENT=$(echo "$RESPONSE" | grep -o '"text": "[^"]*' | sed 's/"text": "//' | sed 's/\\n/\n/g' | sed 's/\\"/"/g')

# 5. Overwrite README.md
if [ ! -z "$AI_CONTENT" ]; then
    echo "$AI_CONTENT" > "$README_FILE"
    echo "README.md updated by AI."

    # 6. Automatic commit
    git add "$README_FILE"
    
    # Simple summary for the commit
    AI_SUMMARY=$(echo "$AI_CONTENT" | head -n 10 | grep -m 1 "^# " | sed 's/# //')
    if [ -z "$AI_SUMMARY" ]; then AI_SUMMARY="updated project overview"; fi
    
    git commit -m "docs (AI): updated README based on commit - $AI_SUMMARY"
    echo "Automated commit created: docs (AI): updated README based on commit - $AI_SUMMARY"
else
    echo "ERROR: Failed to get content from Gemini API."
    echo "Response preview: $(echo "$RESPONSE" | head -c 100)..."
fi

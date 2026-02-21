#!/bin/bash

# Configuration
PROMPT_FILE=".agent/prompts/readme-update.md"
README_FILE="README.md"

# Extract GEMINI_API_KEY from ~/.zshrc if it's not in the environment
if [ -z "$GEMINI_API_KEY" ]; then
    export GEMINI_API_KEY=$(grep "export GEMINI_API_KEY=" ~/.zshrc | head -n 1 | cut -d'"' -f2)
fi

if [ -z "$GEMINI_API_KEY" ]; then
    echo "ERROR: GEMINI_API_KEY not found."
    exit 1
fi

# 1. Prevent infinite recursion
LAST_COMMIT_MSG=$(git log -1 --pretty=%B)
if [[ "$LAST_COMMIT_MSG" =~ ^docs\ \(AI\): ]]; then
    exit 0
fi

# 2. Gather context
export COMMIT_MSG=$(git log -1 --pretty=%B)
export DIFF=$(git show -p HEAD)
export INSTRUCTIONS=$(cat "$PROMPT_FILE")

# 3. Call Gemini API using Python for safe JSON handling
echo "Triggering Gemini AI to update README.md..."

AI_CONTENT=$(python3 <<'EOF'
import json
import http.client
import os
import sys

# Data from environment to avoid escaping issues
instructions = os.environ.get("INSTRUCTIONS", "")
commit_msg = os.environ.get("COMMIT_MSG", "")
diff = os.environ.get("DIFF", "")
api_key = os.environ.get("GEMINI_API_KEY", "")
model = "gemini-flash-latest"

system_instructions = """You are a documentation expert. Based on the commit message and diff provided, update the README.md file. 
Rules: 
- Use English.
- Sections: Summary, Structure, Technologies, Extra Details.
- Never touch source code.
- Never touch .agent folder.
- Return ONLY the raw markdown content for the README.md file."""

prompt = f"{system_instructions}\n\nInstructions from user:\n{instructions}\n\nCommit Message:\n{commit_msg}\n\nDiff:\n{diff}"

# Build Payload
payload = {
    "contents": [{
        "parts": [{"text": prompt}]
    }]
}

# Request
conn = http.client.HTTPSConnection("generativelanguage.googleapis.com")
headers = {"Content-Type": "application/json"}
conn.request("POST", f"/v1beta/models/{model}:generateContent?key={api_key}", json.dumps(payload), headers)

response = conn.getresponse()
res_data = response.read().decode()
data = json.loads(res_data)

try:
    if "error" in data:
        print(f"ERROR: API returned error. {json.dumps(data['error'])}", file=sys.stderr)
        sys.exit(1)
    text = data["candidates"][0]["content"]["parts"][0]["text"]
    print(text)
except (KeyError, IndexError):
    print(f"ERROR: Unexpected response structure. {res_data}", file=sys.stderr)
    sys.exit(1)
EOF
)

# 4. Overwrite README.md
if [ $? -eq 0 ] && [ ! -z "$AI_CONTENT" ]; then
    echo "$AI_CONTENT" > "$README_FILE"
    echo "README.md updated by AI."

    # 5. Automatic commit
    git add "$README_FILE"
    AI_SUMMARY=$(echo "$COMMIT_MSG" | head -n 1)
    git commit -m "docs (AI): updated README based on commit - $AI_SUMMARY"
    echo "Automated commit created: docs (AI): updated README based on commit - $AI_SUMMARY"
else
    echo "ERROR: AI README update failed."
fi

#!/bin/bash
set -e

export org="Rochith" # e.g. "UpSync-Dev" or "ma3574"
export user="Rochith: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" # "ma3574:somemadeuptoken"
export branch="main" # e.g. master or main

declare -a repositories=(
    "Clear"
)

JSON=$(cat << 'EOF'
    {
        "required_status_checks": null,
        "enforce_admins": true,
        "required_pull_request_reviews": {
            "required_approving_review_count": 0
        },
        "restrictions": null
    }
EOF
)

for repository_name in "${repositories[@]}"; do
    echo "========"
    echo "=======> $repository_name"
    echo "========"
        
    curl \
        --silent \
        --user $user \
        --header "Accept: application/vnd.github.v3+json" \
        --request PUT \
        https://api.github.com/repos/$org/$repository_name/branches/$branch/protection \
        --data "$JSON"

done

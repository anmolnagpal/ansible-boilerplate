#!/usr/bin/env bash


GITHUB_API=https://api.github.com
CI_CONTEXT="Testing"

# Notify GitHub build status

curl "$GITHUB_API/repos/${DRONE_REPO_OWNER}/${DRONE_REPO_NAME}/statuses/${DRONE_COMMIT}?access_token=$github_token" \
  -s \
  -H "Content-Type: application/json" \
  -X POST \
  -d "{\"state\": \"${DRONE_BUILD_STATUS}\", \"description\": \"Drone build finished\", \"target_url\": \"${DRONE_BUILD_LINK}\", \"context\": \"$CI_CONTEXT\"}" \
  > /dev/null

exit 0
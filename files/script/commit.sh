#!/usr/bin/env bash

GITHUB_TOKEN=8b6c565cc3449caecf52b7a9c4dd887a1332b16d
GITHUB_API=https://api.github.com
GITHUB_STATUS_ENDPOINT=$GITHUB_API/repos/tajawal/${DRONE_REPO_NAME}/statuses/${DRONE_COMMIT_SHA}
CI_CONTEXT="test"



# Notify GitHub stylechecking has started
echo 'Starting ...'
curl "$GITHUB_API/repos/tajawal/${DRONE_REPO_NAME}/statuses/${DRONE_COMMIT_SHA}?access_token=$GITHUB_TOKEN" \
  -s \
  -H "Content-Type: application/json" \
  -X POST \
  -d "{\"state\": \"pending\", \"description\": \"Ansible checks is in progress\", \"target_url\": \"${DRONE_BUILD_LINK}\", \"context\": \"$CI_CONTEXT\"}" \
  > /dev/null

# Run
cd ../../
ansible-playbook -i localtest/inventory localtest/ci-test.yml --connection=local -vvv --syntax-check
EXIT_CODE=$?

# Notify GitHub
if [[ $EXIT_CODE == 0 ]]
then
  export STATUS="success"
  export DESCRIPTION="No style issues"
  echo $DESCRIPTION
else
  export STATUS="failure"
  export DESCRIPTION="Ansible issues"
  echo $DESCRIPTION
fi

curl "$GITHUB_API/repos/tajawal/${DRONE_REPO_NAME}/statuses/${DRONE_COMMIT_SHA}?access_token=$GITHUB_TOKEN" \
  -s \
  -H "Content-Type: application/json" \
  -X POST \
  -d "{\"state\": \"$STATUS\", \"description\": \"$DESCRIPTION\", \"target_url\": \"${DRONE_BUILD_LINK}\", \"context\": \"$CI_CONTEXT\"}" \
  > /dev/null

exit 0 # don't make the build fail, just notify GitHub
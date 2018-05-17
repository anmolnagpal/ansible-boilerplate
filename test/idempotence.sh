#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'


echo "${YELLOW}#####################################${NC}\n${YELLOW}#${NC} ${GREEN}Check idempotence nature of the role#${NC}\n${YELLOW}#####################################${NC}"
ansible-playbook -i test/inventory test/ci-test.yml --connection=local | grep -q 'changed=0.*failed=0' && (echo 'Idempotence test: pass' && exit 0) || (echo 'Idempotence test: fail' && exit 1)

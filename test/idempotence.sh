#!/usr/bin/env bash

echo "#####################################\nCheck idempotence nature of the role:\n#####################################"
"ansible-playbook -i test/inventory test/ci-test.yml --connection=local | grep -q 'changed=0.*failed=0' && (echo 'Idempotence test: pass' && exit 0) || (echo 'Idempotence test: fail' && exit 1)"

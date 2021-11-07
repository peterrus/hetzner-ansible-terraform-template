#!/usr/bin/env bash
set -e

cd $(dirname "${BASH_SOURCE[0]}") 

[ -f ./secrets.yml.enc ] && VAULT_PW_ARGUMENT="-e @secrets.yml.enc --ask-vault-password"

ansible-playbook -K $VAULT_PW_ARGUMENT -i ./hosts.yml ./main.yml --diff "$@"


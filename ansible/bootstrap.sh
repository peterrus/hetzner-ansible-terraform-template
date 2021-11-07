#!/usr/bin/env bash
set -e

cd $(dirname "${BASH_SOURCE[0]}") 

# Add ansible-galaxy install commands here
ansible-galaxy install geerlingguy.docker geerlingguy.nodejs
ansible-galaxy collection install community.general
ansible-galaxy collection install ansible.posix

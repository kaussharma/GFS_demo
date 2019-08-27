#!/usr/bin/env bash
set -e


if ! [ -x "$(command -v python3)" ]; then
  echo 'Error: python3 is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v jq)" ]; then
  echo 'Error: jq is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v terraform)" ]; then
  echo 'Error: terraform not available!.' >&2
  exit 1
fi

if ! [ -x "$(command -v ansible-playbook)" ]; then
  echo 'Error: ansible-playbook not available!.' >&2
  exit 1
fi

if ! [ -x "$(command -v ssh-keygen)" ]; then
  echo 'Error: ssh-keygen not available!.' >&2
  exit 1
fi

if ! [ -x "$(command -v aws)" ]; then
  echo 'Error: aws not available!.' >&2
  exit 1
fi


if [[ -z "$AWS_ACCESS_KEY_ID" && ! -f "$HOME/.aws/credentials" ]]
then
    aws configure
fi




BACKEND_VARS_PATH="$(pwd)/vars/backend.tfbackend"
INFRA_VARS_PATH="$(pwd)/vars/infra.tfvars"

terraform init && terraform apply -auto-approve -input=false -refresh=true -var-file=$BACKEND_VARS_PATH || true

terraform init -input=false -backend=true -backend-config=$BACKEND_VARS_PATH
[ $? -ne 0 ] && { echo "Execution failed! Exiting..."; exit 1; }

terraform apply -auto-approve -input=false -refresh=true -var-file=$INFRA_VARS_PATH
[ $? -ne 0 ] && { echo "Execution failed! Exiting..."; exit 1; }

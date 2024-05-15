#!/bin/bash

# Deploy Kubernetes cluster using Ansible for a specified environment
# Usage: ./scripts/ansible-deploy.sh [environment]

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Please specify an environment (dev, staging, prod)"
  exit 1
fi

cd ansible

echo "Running Ansible playbook to set up Kubernetes cluster for the $ENVIRONMENT environment..."
ansible-playbook -i inventories/$ENVIRONMENT/hosts playbooks/setup-kubernetes-cluster.yml

if [ $? -ne 0 ]; then
  echo "Failed to deploy Kubernetes cluster using Ansible."
  exit 1
fi

echo "Kubernetes cluster deployed successfully."

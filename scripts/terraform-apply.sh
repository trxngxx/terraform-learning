#!/bin/bash

# Apply Terraform configuration for a specified environment
# Usage: ./scripts/terraform-apply.sh [environment]

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Please specify an environment (dev, staging, prod)"
  exit 1
fi

cd terraform/environments/$ENVIRONMENT

echo "Applying Terraform for the $ENVIRONMENT environment..."
terraform apply -var-file=1-variables.tf

if [ $? -ne 0 ]; then
  echo "Failed to apply Terraform configuration."
  exit 1
fi

echo "Terraform applied successfully."

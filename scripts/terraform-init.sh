#!/bin/bash

# Initialize Terraform for a specified environment
# Usage: ./scripts/terraform-init.sh [environment]

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Please specify an environment (dev, staging, prod)"
  exit 1
fi

cd terraform/environments/$ENVIRONMENT

echo "Initializing Terraform for the $ENVIRONMENT environment..."
terraform init -backend-config=0-backend.hcl

if [ $? -ne 0 ]; then
  echo "Failed to initialize Terraform."
  exit 1
fi

echo "Terraform initialized successfully."

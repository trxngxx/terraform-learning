# Kubernetes Cluster Setup with Terraform and Ansible

This project automates the deployment of a Kubernetes cluster using Terraform and Ansible to AIC. The infrastructure is provisioned using Terraform and the Kubernetes cluster is set up using Ansible playbooks.

## Project Structure


## Prerequisites

- Terraform installed on your local machine.
- Ansible installed on your local machine.
- Access to your cloud provider (e.g., AWS, Azure, GCP) with necessary credentials.

## Setup Instructions

### 1. Initialize Terraform

Navigate to the `scripts` directory and run the `terraform-init.sh` script with the desired environment:

cd scripts
sh ./terraform-init.sh dev

2. Apply Terraform Configuration
After initializing, apply the Terraform configuration to provision the infrastructure:

sh ./terraform-apply.sh dev

3. Deploy Kubernetes Cluster with Ansible
Once the infrastructure is provisioned, use Ansible to set up the Kubernetes cluster:

sh ./ansible-deploy.sh dev

Replace dev with staging or prod as needed for different environments.

Project Details
Terraform
The Terraform configuration is organized into different environments (dev, staging, prod).
The modules directory contains reusable Terraform modules.
Each environment has its own backend configuration and variables.

Ansible
The Ansible playbooks and roles are organized to deploy and configure the Kubernetes cluster.
The inventories directory contains the inventory files for each environment.
The ansible.cfg file is configured to use the correct inventory.

License
This project is licensed under the MIT License. See the LICENSE file for more details.

javascript
### `.gitignore`

Ensure your `.gitignore` file excludes sensitive and unnecessary files from version control:

Terraform files
*.tfstate
*.tfstate.backup
.terraform/

Ansible files
ansible/.vault_pass
ansible/inventories/*/hosts

General files
*.log
*.tmp
*.bak
.DS_Store

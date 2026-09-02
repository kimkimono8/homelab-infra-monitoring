#!/bin/bash
set -e

echo "==> Provisioning infrastructure with Terraform..."
cd terraform
terraform init
terraform apply -auto-approve
cd ..

echo "==> Configuring targets with Ansible..."
cd ansible
ansible-playbook -i inventory/hosts.yml playbooks/site.yml
cd ..

echo "==> Starting monitoring stack..."
cd monitoring
docker compose up -d
cd ..

echo "==> Done! Grafana: http://localhost:3000 (admin/admin)"

#!/bin/bash

## Createing infra
# echo "Createing Vms and other resources"
terraform init
terraform apply -auto-approve

## adding VMs public IPs to ansible inventory

echo "" > ansible/hosts
echo "[APP]" >> ansible/hosts
echo "adminuser@$(terraform output -raw APP_PUBLIC_IP)" >> ansible/hosts
echo "" >> ansible/hosts
echo "[DBC]" >> ansible/hosts
echo "adminuser@$(terraform output -raw MASTERDB_PUBLIC_IP)" >> ansible/hosts
echo "" >> ansible/hosts
echo "adminuser@$(terraform output -raw SLAVEDB_PUBLIC_IP)" >> ansible/hosts
echo "" >> ansible/hosts
echo "[DBM]" >> ansible/hosts
echo "adminuser@$(terraform output -raw MASTERDB_PUBLIC_IP)" >> ansible/hosts
echo "" >> ansible/hosts
echo "[DBS]" >> ansible/hosts
echo "adminuser@$(terraform output -raw SLAVEDB_PUBLIC_IP)" >> ansible/hosts
echo "" >> ansible/hosts

## running ansible automation with extra vars
ansible-playbook -i ansible/hosts ansible/mproj.yaml -e "ansible_become=yes \
DB_NAME=$(terraform output -raw DB_NAME) \
DB_REPLICA_NAME=$(terraform output -raw DB_REPLICA_NAME) \
DB_REPLICA_PASS=$(terraform output -raw DB_REPLICA_PASS) \
DB_USER_NAME=$(terraform output -raw DB_USER_NAME) \
DB_USER_PASS=$(terraform output -raw DB_USER_PASS) \
MASTERDB_PRIVATE_IP=$(terraform output -raw MASTERDB_PRIVATE_IP) \
SLAVEDB_PRIVATE_IP=$(terraform output -raw SLAVEDB_PRIVATE_IP)"
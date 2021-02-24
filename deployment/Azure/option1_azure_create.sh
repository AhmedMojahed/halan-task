#!/bin/bash

## Createing infra
echo "Createing Vms and other resources"
terraform init
terraform apply -auto-approve

## adding VMs public IPs to ansible inventory
cd ansible/
echo "" > hosts
echo "[APP]" >> hosts
terraform output APP_PUBLIC_IP >> hosts
echo "[DBC]" >> hosts
terraform output MASTERDB_PUBLIC_IP >> hosts
terraform output SLAVEDB_PUBLIC_IP >> hosts
echo "[DBM]" >> hosts
terraform output MASTERDB_PUBLIC_IP >> hosts
echo "[DBS]" >> hosts
terraform output SLAVEDB_PUBLIC_IP >> hosts

## running ansible automation with extra vars
asnible-playbook -i hosts mproj.yaml -e "DB_NAME=$(terraform output -raw DB_NAME) \
DB_REPLICA_NAME=$(terraform output -raw DB_REPLICA_NAME) \
DB_REPLICA_PASS=$(terraform output -raw DB_REPLICA_PASS) \
DB_USER_NAME=$(terraform output -raw DB_USER_NAME) \
DB_USER_PASS=$(terraform output -raw DB_USER_PASS) \
MASTERDB_PRIVATE_IP=$(terraform output -raw MASTERDB_PRIVATE_IP) \
SLAVEDB_PRIVATE_IP=$(terraform output -raw SLAVEDB_PRIVATE_IP)"
# Azure Deployment

## Prerequisites
1. [`Install Azure cli`](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
2. [`Install Asnible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
3. [`Install Terraform`]()

### Default values setup
1. First You need to log in to you azure account throgh the cli
```bash
az login
```
you should see an output like this
```bash
[
  {
    "cloudName": "AzureCloud",
    "id": "00000000-0000-0000-0000-000000000000",
    "isDefault": true,
    "name": "PAYG Subscription",
    "state": "Enabled",
    "tenantId": "00000000-0000-0000-0000-000000000000",
    "user": {
      "name": "user@example.com",
      "type": "user"
    }
  }
]
```
2. Start Building the infrastructure on `Azure`
```bash
bash option1_azure_create.sh
```
3. To test app running with default values first you need to get the App vm public ip
- in the same folder run the following command
```bash
terraform output APP_PUBLIC_IP
```
and use it as the following
- `http://192.168.44.10`
- `http://192.168.44.10/?n=5`
- `http://192.168.44.10/ip`
- `http://192.168.44.10/allips`

4. to access any machine you need to get the vm public ip
use the following commands to get the ips
```bash 
terraform output APP_PUBLIC_IP
terraform output MASTERDB_PUBLIC_IP
terraform output SLAVE_PUBLIC_IP
```
now ssh into any machine
```bash
ssh adminuser@<vm_ip>
```
5. To Destroy all resources
```bash
bash option1_azure_destroy.sh
```

### Customizing default values
For customization change the default values in [`variables.tf`](/deployment/Azure/variables.tf) file and run the same commads as above.

### Note:
You may need to create `terraform.tfvars` file for storing sensitive data like passwords and access keys and delete only `default` field from `variables.tf` file 
the format 
```bash 
DB_USER_PASS = "devops"
``` 
Then add `terraform.tfvars` file to the gitignore for not exposing you secrets
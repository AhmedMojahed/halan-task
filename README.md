# devops-task
This is a solution for the writen [task](/DevOps_Challenge.pdf)

## Deployment: Option #1
In this option we will use 2 methods choose what you want.

- [`local`](/deployment/local/)
- [`Azure`](/deployment/Azure/)

In this option we will deploy 3 node app:
- App server. node1
- MasterDB VM (postgresql-13) node2
- SlaveDB VM for replication node3

### Getting Started

1. Clone this repo
```bash
git clone https://github.com/AhmedMojahed/devops-task.git
```
or just download the zip file
2. Navigate to the repo directory
```bash
cd devops-task
```

### Local(on-premise) Deployment

### Prerequisites
1. [`Install Vagrant`](https://www.vagrantup.com/downloads)
2. [`Install Asnible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
3. [`Install virtualbox`](https://www.virtualbox.org/wiki/Downloads)

### Go to the [`local`](/deployment/local/) deployment folder for more instruction on how to use the solution


### Azure Deployment

### Prerequisites
1. [`Install Azure cli`](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
2. [Install Asnible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

### Go to the [`Azure`](/deployment/Azure/) deployment folder for more instruction on how to use the solution


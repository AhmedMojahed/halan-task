# devops-task
This is a solution for the writen [task](/InfrastructureTestAssignment.pdf)

## Deployment: Option #1

## Local(on-premise) Deployment

In this option we will deploy 3 node app:
- App server. node1
- MasterDB VM (postgresql-13) node2
- SlaveDB VM for replication node3

### Prerequisites
1. [Install Vagrant](https://www.vagrantup.com/downloads)
2. [Install Asnible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
3. [Install virtualbox](https://www.virtualbox.org/wiki/Downloads)

### Getting Started

1. Clone this repo
```bash
git clone https://github.com/AhmedMojahed/devops-task.git
```
2. Change your directory to the repo
```bash
cd devops-task
```
3. For auto deployment with default values:
```bash
bash option1.sh up
```
4. For powering off all vms
```bash
bash option1.sh halt
```
5. For destroying all vms
```bash
bash option1.sh destroy
```
6. To ssh into any machine run the following command in repo [vagrant folder](/deployment/on-premise/vagrant/)
```bash
cd deployment/on-premise/vagrant/
vagrant ssh node1   # to connect to app machine
vagrant ssh node2   # to connect to MasterDB machine
vagrant ssh node3   # to connect to SlaveDB machine
```

### Note:
- You can change defualt values by changing extra_vars in [vagrantfile](/deployment/on-premise/vagrant/Vagrantfile) and run the same command in step 3.
Uncomment and change values as you like.
 ```bash
 ansible.extra_vars = { 
            ansible_python_interpreter: "/usr/bin/python3",
            # DB_NAME: "devops",
            # DB_USER_NAME: "devops",
            # DB_USER_PASS: "devops",
            # DB_REPLICA_NAME: "replica",
            # DB_REPLICA_PASS: "replica",
            # MASTERDB_PRIVATE_IP: "192.168.44.11",
            # SLAVEDB_PRIVATE_IP: "192.168.44.12"
          }
```
- If you want to deploy on any cloud provider you can by changing the prider in [vagrantfile](/deployment/on-premise/vagrant/Vagrantfile) and provider configuration in the docs.

## Deployment: Option #2

## Kubernetes Cluster.

### Prerequisites
1.
2.
3.

### Getting Started

1. Clone this repo
```bash
git clone https://github.com/AhmedMojahed/devops-task.git
```
2. Change your directory to the repo
```bash
cd devops-task
```
For auto deployment with default values:
```bash
bash option2.sh
```
you can change defualt values in variables file and run the same command above. 



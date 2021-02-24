# Local(on-premise) Deployment

## Prerequisites
1. [`Install Vagrant`](https://www.vagrantup.com/downloads)
2. [`Install Asnible`](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
3. [`Install virtualbox`](https://www.virtualbox.org/wiki/Downloads)

## Getting Started

### Default values setup
1. For auto deployment with default values:
```bash
bash option1.sh up
```
2. For powering off all vms
```bash
bash option1.sh halt
```
3. For destroying all vms
```bash
bash option1.sh destroy
```
4. To ssh into any machine run the following commands 
```bash
vagrant ssh node1   # to connect to app machine 
vagrant ssh node2   # to connect to MasterDB machine
vagrant ssh node3   # to connect to SlaveDB machine
```
7. To test app running with default values go to 
- `http://192.168.44.10`
- `http://192.168.44.10/?n=5`
- `http://192.168.44.10/ip`
- `http://192.168.44.10/allips`

### Customizing default values
- You can change the defualt values of the database by changing extra_vars in [`vagrantfile`](/deployment/local/vagrant/Vagrantfile)
Uncomment and change values as you like.
 ```bash
    ansible.extra_vars = { 
        ansible_python_interpreter: "/usr/bin/python3",
        # DB_NAME: "devops",
        # DB_USER_NAME: "devops",
        # DB_USER_PASS: "devops",
        # DB_REPLICA_NAME: "replica",
        # DB_REPLICA_PASS: "replica",
        # APP_PRIVATE_IP: "192.168.44.10",
        # MASTERDB_PRIVATE_IP: "192.168.44.11",
        # SLAVEDB_PRIVATE_IP: "192.168.44.12"
    }
```
- Save the file and run the same commands above.

#!/bin/bash

ARG=$1

cd development/devops-task/deployment/on-premise/vagrant/
if [[$ARG -eq "up"]]
then
    echo "creating vms" 
    vagrant $ARG
elif  [[ $ARG -eq "halt" ]]
    echo "shuting down vms" 
    vagrant $ARG -f
elif  [[ $ARG -eq "destroy" ]]
    echo "destroying vms" 
    vagrant $ARG -f
fi


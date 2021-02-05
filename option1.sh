#!/bin/bash

ARG=$1

cd deployment/on-premise/vagrant/
if [[ $ARG -eq "up" ]]
then
    echo "creating vms" 
    vagrant $ARG
elif [[ $ARG -eq "halt" ]]
then
    echo "shuting down vms" 
    vagrant $ARG -f
elif [[ $ARG -eq "destroy" ]]
then
    echo "destroying vms" 
    vagrant $ARG -f
fi


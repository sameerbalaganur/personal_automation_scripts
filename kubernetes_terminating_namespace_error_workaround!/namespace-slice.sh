#!/bin/bash
terminatingNamespace=$1
# terminatingNamespace="nginx-loadbalancer"
echo -e "\e[1m\e[39mReplace the finalizers from the following namespace's template.json for a terminating namespace\e[0m\e[21m"
echo -e "\e[1m\e[39m----------------------------------------------------------\e[0m\e[21m"
echo -e "\e[1m\e[39mCreate get the template.json.\e[0m\e[21m"
make_template=$(kubectl get namespaces "$terminatingNamespace" -o json > tempfile.json)
echo "$make_template"
namespace_status=$(kubectl get namespaces "$terminatingNamespace" -o jsonpath="Name: {.metadata.name} Status: {.status.phase}" | awk '{print $4}')
echo "$namespace_status"
if namespace_status="Terminating"
then 
    echo -e "\e[1m\e[39mGet the template.json.\e[0m\e[21m"
    remove_finalizers=$(sed -i '/\"finalizers\"/,/]/ d' tempfile.json)
    echo "$remove_finalizers"
    replace_temp_json=$(kubectl replace --raw "/api/v1/namespaces/$terminatingNamespace/finalize" -f tempfile.json)
    echo "$replace_temp_json"

else
    echo -e "\e[1m\e[39mNamespace is not terminating.\e[0m\e[21m"
fi
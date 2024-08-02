#!/bin/bash

# Display help message
help() {
  cat <<EOF
  Usage: $0 [command]
  Commands:
     verify       Verify the current context is a colima kubernetes cluster
     deploy       Deploy apache kafka and zookeeper on the running cluster
     uninstall    Uninstall apache kafka and zookeeper

 Example:
   echo "${0##*/} install"
EOF
}

# Check if at least one argument is provided
if [ "$#" -lt 1 ]; then
  help
  exit 1
fi

# Verify the current kubernetes cluster context
verify() {
  if [[ $(kubectl config current-context) == "colima" ]]; then
    echo "Cluster set to colima"
    exit 0
  else
    echo "Wrong kubernetes cluster. Change context to colima"
    exit 1
  fi
}

# Common function for building and applying/deleting kustomize configuration
kustomize_action() {
  local action=$1
  local ret="kustomize build kafka/base"
  cd kustomize
  
  if ! $ret; then
    echo "Something is incorrect with the deployment files"
    exit 1
  fi
  
  $ret | kubectl $action -f -
}

# Deploy apache kafka and zookeeper
deploy() {
  kustomize_action "apply"
}

# Uninstall apache kafka and zookeeper
uninstall() {
  kustomize_action "delete"
}

# Execute the specified command
"$@"

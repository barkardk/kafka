# Kafka Installation Script

This script installs and configures Apache Kafka and Zookeeper on a local Colima Kubernetes cluster.

## Requirements

* Colima installed and running on your local machine
* kubectl configured to use the Colima cluster
* kustomize installed

## Script

The installation script is located in `install.sh`. You can run it with the following commands:
* `make verify` to verify that the current cluster is a running Colima instance
* `make deploy` to deploy Kafka to the local Colima cluster
* `make delete` to uninstall Kafka

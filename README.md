This repository automates the deployment of a Kubernetes cluster using Kubespray and installs WordPress, phpMyAdmin, and MySQL via a Helm chart.

## Overview

Main Script: `bootstrap.sh`  
  Running this script will:
  * Deploy a Kubernetes cluster using Kubespray.
  * Install WordPress, phpMyAdmin, and MySQL using the Helm chart (`wordpress-chart`).

Helm Chart: `wordpress-chart`  
  This chart is responsible for managing the installation and configuration of the services.

## Getting Started
1. **Clone the Repository:**
```
   git clone https://github.com/Niirvana23/devops-test.git
   cd devops-test
```
2. **Make the Bootstrap Script Executable:**
```
chmod +x bootstrap.sh
```
3. **Run the Bootstrap Script:**
```
   ./bootstrap.sh
```
The script will:
  * Deploy a Kubernetes cluster using Kubespray.
  * Install WordPress, phpMyAdmin, and MySQL using the wordpress-chart.

## Domain Configuration
The deployed services will be accessible through the following domains:

WordPress:
http://alinoori.maxtld.dev/wordpress

phpMyAdmin:
http://alinoori.maxtld.dev/dbadmin

## Important Note:
The domain maxtld.dev is not available for public DNS. You must configure the DNS settings on the local system where the deployment is executed.

## Verify DNS Resolution with curl:
After updating your hosts file, verify that the domains resolve correctly:
```
curl http://alinoori.maxtld.dev/wordpress
curl http://alinoori.maxtld.dev/dbadmin
```
You should see the WordPress site and phpMyAdmin interface (or their respective HTML responses).


FROM amazon/aws-cli:latest

#install system tools
RUN yum install -y yum-utils

# Use yum-config-manager to add the official HashiCorp Linux repository
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Terraform
RUN yum -y install terraform

# Install Git
RUN yum -y install git
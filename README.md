# Sumary

The terraform code creates a VM in the Azure environment as is asked in the DevOps assignment.

# Configuration and structure 
├── backend.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── ssh.tf
└── variables.tf
# How works
Once the code is executed, it creates 2 virtual machines with a network interface and Security groups with port 80 allowed to the Internet and port 22 just allowing for specific IP that is used to connect in the virtual machine and execute the remote exec that installs the Nginx to be accessible using the public IP.

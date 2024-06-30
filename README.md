# Sumary
The terraform code creates a VM in the Azure environment as is asked in the DevOps assignment.

# Configuration and structure 
├── backend.tf <br/>
├── main.tf <br/>
├── outputs.tf <br/>
├── providers.tf <br/>
├── ssh.tf <br/>
└── variables.tf <br/>
# How works
Once the code is executed, it creates 2 virtual machines with a network interface and Security groups with port 80 allowed to the Internet and port 22 just allowing for specific IP that is used to connect in the virtual machine and execute the remote exec that installs the Nginx to be accessible using the public IP.
# Resources created screenshot
Terraform Code with Success log:
![Screenshot 2024-06-30 at 14 14 33](https://github.com/thiagod2/terraform-azure/assets/85693497/5c516ece-d39d-413f-bf70-776ddaa2bf3e)

Azure Portal with the 2 Virtual Machines created:
![Screenshot 2024-06-30 at 14 15 23](https://github.com/thiagod2/terraform-azure/assets/85693497/98743a71-bd7e-4878-a8dc-b4bab5b58ea1)

Public IP with Nginx showing up:
![Screenshot 2024-06-30 at 14 37 48](https://github.com/thiagod2/terraform-azure/assets/85693497/9013fee9-ef7b-49e8-8bb6-769d00d62722)
# Final consideration
With that, the assignment that asks to automate the creation is done.

# References <br/>
1 - https://medium.com/turknettech/how-to-create-vms-in-azure-with-terraform-32b85965a0af <br/>
2 - https://learn.microsoft.com/pt-br/azure/virtual-machines/linux/quick-create-terraform?tabs=azure-cli <br/>

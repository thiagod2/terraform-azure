# Sumary
The terraform code creates a Database SQL in the Azure environment.

# Configuration and structure 
├── README.md <br/>
├── main.tf <br/>
├── outputs.tf <br/>
├── providers.tf <br/>
└── variables.tf <br/>
# How works
Once the code is executed, it creates 1 Database SQL that have a firewall allowing connection just for one IP.
# Resources created screenshot
Terraform code with Success log:

Azure Portal with the SQL Database created:


Ping test from my local terminal:

# Final consideration
With that, the assignment that asks to automate the creation is done.

# References <br/>
1 - https://learn.microsoft.com/en-us/azure/azure-sql/database/single-database-create-terraform-quickstart?view=azuresql&tabs=azure-cli <br/>
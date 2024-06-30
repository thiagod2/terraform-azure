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
![Screenshot 2024-06-30 at 16 52 48](https://github.com/thiagod2/terraform-azure/assets/85693497/a2cfb70b-4164-4e4d-96b5-789f4b3213f8)

Azure Portal with the SQL Database created:
![Screenshot 2024-06-30 at 16 56 14](https://github.com/thiagod2/terraform-azure/assets/85693497/79ad0115-fd63-4541-842e-2e71b475ed0c)


Ping test from my local terminal:
![Screenshot 2024-06-30 at 16 59 13](https://github.com/thiagod2/terraform-azure/assets/85693497/84ed5a56-1dcf-4d3e-a361-b386b422d4fa)

# Final consideration
With that, the assignment that asks to automate the creation is done.

# References <br/>
1 - https://learn.microsoft.com/en-us/azure/azure-sql/database/single-database-create-terraform-quickstart?view=azuresql&tabs=azure-cli <br/>

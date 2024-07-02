# Sumary
This simple Python code is used to get the CPU usage for specific VMs in Azure we can search the resource using the variables
vm_name and resource_group_name.

# How to use it
First, we need to install the modules <code>azure-identity</code> and <code>azure-mgmt-monitor</code> using the pip install after that we need to import or AZURE_SUBSCRIPTION_ID using the environment variables 
<code>export AZURE_SUBSCRIPTION_ID=xxxxx-xxxx-xxxxxxx</code> after the import run in your terminal the command <code>python monitor.py</code>.

# Output
If everything works fine we should have this message in the terminal:
<img width="1440" alt="Screenshot 2024-07-02 at 16 25 03" src="https://github.com/thiagod2/terraform-azure/assets/85693497/d7d2d02a-d18f-474c-b75b-6bb43ac9291b">

# References

1 - https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/monitor/azure-monitor-query

2 - https://learn.microsoft.com/en-us/python/api/overview/azure/mgmt-monitor-readme?view=azure-python

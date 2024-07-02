import os
from azure.identity import DefaultAzureCredential
from azure.mgmt.monitor import MonitorManagementClient
from datetime import datetime, timedelta


# Authentication
credential = DefaultAzureCredential()
subscription_id = os.environ.get('AZURE_SUBSCRIPTION_ID')
if not subscription_id:
   raise ValueError("The variable 'AZURE_SUBSCRIPTION_ID' is not defined.")


monitor_client = MonitorManagementClient(credential, subscription_id)


resource_group_name = 'manual-resources'
vm_name = 'teste-machine'
resource_id = f'/subscriptions/{subscription_id}/resourceGroups/{resource_group_name}/providers/Microsoft.Compute/virtualMachines/{vm_name}'


#Function to get CPU usage
def get_cpu_usage(resource_id):
   # Define parameters to take the last 5 minutes in the printf
   end_time = datetime.utcnow()
   start_time = end_time - timedelta(minutes=5)


   # Get metrics about CPU usage
   metrics_data = monitor_client.metrics.list(
       resource_id,
       timespan=f"{start_time}/{end_time}",
       interval='PT1M',
       metricnames='Percentage CPU',
       aggregation='Average'
   )


   for item in metrics_data.value:
       for timeserie in item.timeseries:
           for data in timeserie.data:
               cpu_usage = data.average
               if cpu_usage is not None:
                print(f"Time: {data.time_stamp}, CPU Usage: {data.average}%")
                if cpu_usage > 80:
                   print(f"WARNING: CPU usage is higher than 80%! {cpu_usage}%")


if __name__ == "__main__":
   get_cpu_usage(resource_id)




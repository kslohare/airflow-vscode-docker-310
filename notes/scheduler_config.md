# scheduler 
It is part of the Airflow core distribution — it doesn’t have a separate version. Its version is the same as the installed Airflow version.

# Doc
https://airflow.apache.org/docs/apache-airflow/stable/administration-and-deployment/scheduler.html

# Scheduler Configuration options
## In case scheduler failing then 
Go to airflow.cfg -> add below option under [core]
execution_api_server_url = http://localhost:9001/execution/

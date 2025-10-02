from airflow.decorators import dag, task
from datetime import datetime

@dag(schedule_interval="@daily", start_date=datetime(2025, 9, 27), catchup=False, 
     tags=["hello", "airflow-vscode-docker"])
def hello_airflow_vscode_docker():
    @task
    def say_hello():
        print("Hello from airflow-vscode-docker!")

    say_hello()

dag = hello_airflow_vscode_docker()

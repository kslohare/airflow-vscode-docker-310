from airflow.decorators import dag, task
from datetime import datetime
import pendulum

# use a timezone-aware datetime (recommended)
start = pendulum.datetime(2025, 9, 27, tz="UTC")

@dag(schedule="@daily", start_date=start, catchup=False, tags=["hello", "airflow-vscode-docker"])
def hello_airflow_vscode_docker():
    @task
    def say_hello():
        print("Hello from airflow-vscode-docker!")

    say_hello()

dag = hello_airflow_vscode_docker()

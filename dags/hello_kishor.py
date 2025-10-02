# File: dags/hello_kishor.py
from datetime import datetime
from airflow import DAG
from airflow.providers.standard.operators.python import PythonOperator

def hello_task():
    print("Hello Kishor Lohare")

with DAG(
    dag_id="hello_kishor_dag",
    start_date=datetime(2025, 9, 28),
    schedule=None,       # Run only once
    catchup=False,       # No backfill
    tags=["hello"]       # Tag name set as 'hello'
) as dag:

    task_hello = PythonOperator(
        task_id="print_hello",
        python_callable=hello_task
    )

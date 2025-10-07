https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html#declaring-a-dag
1) Creating new dag
python -m py_compile py_compile dags/hello_kishor.py
python dags/hello_kishor.py

### Check Airflow import errors (if any):
airflow dags list-import-errors

If this shows tracebacks, fix the file accordingly and repeat step 1.
### Confirm the DAG is visible:
airflow dags list | grep hello_kishor_dag

(Quick test-run of the task — runs locally without scheduler)
This is great for debugging — it runs the task callable directly and shows stdout:
airflow tasks test hello_kishor_dag say_hello 2025-09-28

You should see Hello Kishor Lohare in the output.

### Trigger the DAG (create a DagRun):
airflow dags trigger hello_kishor_dag

View logs (after trigger):
airflow tasks list hello_kishor_dag
airflow tasks logs hello_kishor_dag say_hello
### or tail the dag_processor logs to watch parsing:
```
tail -n 200 ~/code/airflow-vscode-docker-310/airflow_home/logs/dag_processor/*.log
```

## Creating DAG step by step  - start
### create a dag file
user_processing.py and add @dag decorator with function
```
@dag
def user_processing():
  pass

```

### Create table
```
@dag
def user_processing():
    create_table = SQLExecuteQueryOperator (
        task_id="create_table",
        conn_id="postgres",
        sql="""
        CREATE TABLE IF NOT EXISTS users (
            id  INT PRIMARY KEY,
            firstname VARCHAR(255),
            lastname VARCHAR(255),
            email VARCHAR(255),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
        """
    )
```

### Creating Postgress connection
Airflow ui > Admin > Connection  > Add Connection


### Add new providers
Using Astronomer site

### Test Dag task
airflow tasks list user_processing
airflow tasks test user_processing create_table

## Creating DAG step by step  - complete

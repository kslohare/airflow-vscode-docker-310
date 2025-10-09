# Operator 
Defines a single unit of work — i.e., what action a task will perform.

Think of an Operator as:

🧱 “A template for a task.”

When you create a DAG, each task is an instance of an Operator.

## Example Analogy
| Concept                  | Example                               |
| ------------------------ | ------------------------------------- |
| **Operator (Blueprint)** | “Run a Python function”               |
| **Task (Instance)**      | “Run `transform_data()` function”     |
| **DAG (Workflow)**       | “Extract → Transform → Load” pipeline |


## Why Use Operators?
Operators:

Define what should be done (e.g., run SQL, call API, copy file).

Allow Airflow to schedule and manage execution.

Support retry logic, dependencies, and logging automatically.

Provide reusability and extensibility.

## Types of Operators
There are three broad categories of Operators in Airflow:
| Category               | Description                                             | Example                                           |
| ---------------------- | ------------------------------------------------------- | ------------------------------------------------- |
| **Action Operators**   | Perform an action (run a script, query, API call, etc.) | `PythonOperator`, `BashOperator`, `EmailOperator` |
| **Transfer Operators** | Move data between systems                               | `S3ToRedshiftOperator`, `MySQLToGCSOperator`      |
| **Sensor Operators**   | Wait for a condition to be met                          | `S3KeySensor`, `ExternalTaskSensor`               |

## Commonly Used Operators
### PythonOperator : Runs a Python function
```python
from airflow.operators.python import PythonOperator

def greet():
    print("Hello from PythonOperator!")

task = PythonOperator(
    task_id='greet_task',
    python_callable=greet,
)
```

### BashOperator : Executes a Bash command or shell script.
```python
from airflow.operators.bash import BashOperator

task = BashOperator(
    task_id='print_date',
    bash_command='date',
)
```
### EmailOperator : Sends an email.
```
from airflow.operators.email import EmailOperator

task = EmailOperator(
    task_id='send_email',
    to='user@example.com',
    subject='Airflow Task Completed',
    html_content='<h3>Task completed successfully!</h3>',
)
```
### DummyOperator / EmptyOperator : A placeholder task (useful for testing or grouping).
```python
from airflow.operators.empty import EmptyOperator

start = EmptyOperator(task_id='start')
end = EmptyOperator(task_id='end')

```
### BranchPythonOperator : Runs one of several paths based on a condition.
```python
from airflow.operators.python import BranchPythonOperator

def choose_path():
    return 'task_a' if True else 'task_b'

branch = BranchPythonOperator(
    task_id='branching',
    python_callable=choose_path,
)
```

### Sensor Operators : Wait for a condition before proceeding (e.g., file, table, or time).
```
from airflow.sensors.filesystem import FileSensor

wait_for_file = FileSensor(
    task_id='wait_for_data_file',
    filepath='/data/input.csv',
    poke_interval=30,
)
```

## Provider-Specific Operators
Each provider (integration package) adds its own operators.

For example:
| Provider     | Example Operator        | Description                                     |
| ------------ | ----------------------- | ----------------------------------------------- |
| **AWS**      | `S3ToRedshiftOperator`  | Load data from S3 to Redshift                   |
| **GCP**      | `GCSToBigQueryOperator` | Load data from Google Cloud Storage to BigQuery |
| **Postgres** | `PostgresOperator`      | Run SQL queries in Postgres                     |
| **Docker**   | `DockerOperator`        | Run tasks inside Docker containers              |

## Custom Operator Example :You can also create your own operator by subclassing BaseOperator
```python
from airflow.models import BaseOperator

class MyCustomOperator(BaseOperator):
    def __init__(self, message, **kwargs):
        super().__init__(**kwargs)
        self.message = message

    def execute(self, context):
        print(f"Custom operator says: {self.message}")

```
Then use it in a DAG:
```python
from airflow import DAG
from airflow.utils.dates import days_ago

with DAG('custom_operator_dag', start_date=days_ago(1), schedule=None) as dag:
    my_task = MyCustomOperator(
        task_id='custom_task',
        message='Hello from custom operator!',
    )

```


## Summary Table
| Type                   | Purpose                                      | Example                                           |
| ---------------------- | -------------------------------------------- | ------------------------------------------------- |
| **Action Operators**   | Perform actions (run code, send email, etc.) | `PythonOperator`, `BashOperator`, `EmailOperator` |
| **Transfer Operators** | Move data between systems                    | `S3ToRedshiftOperator`, `MySQLToGCSOperator`      |
| **Sensor Operators**   | Wait for external events or files            | `S3KeySensor`, `FileSensor`                       |
| **Custom Operators**   | Build your own logic                         | `MyCustomOperator`                                |


##Key Points

Each task = 1 Operator instance.

Operators don’t do scheduling — they just define what to do.

Use Sensors to wait, Operators to act, and Providers to extend integrations.
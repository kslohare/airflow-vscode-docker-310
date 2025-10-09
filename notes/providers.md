# providers
Usage - Import provider components into your DAGs

providers are modular plugin packages that contain integrations for specific external systems, cloud services, databases, APIs, or tools.

They extend Airflow’s core functionality — adding **Hooks**, **Operators**, **Sensors**, **Transfer operators**, and **Secrets** **backends** for various platforms (like AWS, GCP, MySQL, etc.) without needing to modify the Airflow core.

A provider is a Python package (installed via pip) that Airflow uses to interact with an external service.

Each provider package follows the naming convention:

```bash
apache-airflow-providers-<service>
```

For example:
```bash
apache-airflow-providers-amazon → AWS integration

apache-airflow-providers-google → GCP integration

apache-airflow-providers-postgres → PostgreSQL integration

apache-airflow-providers-docker → Docker integration
```

# Typical Components Inside a Provider

Each provider package can contain:
| Component              | Description                                                                         |
| ---------------------- | ----------------------------------------------------------------------------------- |
| **Hook**               | Python interface for connecting to an external system (e.g., S3Hook, PostgresHook). |
| **Operator**           | Defines a unit of work (task) using a Hook (e.g., S3ToRedshiftOperator).            |
| **Sensor**             | Waits for a condition to be met (e.g., waiting for a file in S3).                   |
| **Connection type**    | Defines UI fields for connection configuration.                                     |
| **Transfer operators** | Move data between systems.                                                          |
| **Secrets backend**    | Manage connections via secret managers (e.g., AWS Secrets Manager).                 |

***

# How to Install a Provider
Example: Using a Provider (Amazon S3)

## Step 1: Install the provider
pip install apache-airflow-providers-amazon

## Step 2: Add AWS Connection in Airflow UI
Go to Airflow UI → Admin → Connections

Create a new connection:

Conn Id: aws_default

Conn Type: Amazon Web Services

Extra (JSON):
{"region_name": "us-east-1"}

## Step 3: Example DAG using the S3Hook
# Example: Using Amazon Provider in Apache Airflow 3.1

Below DAG uploads a text file to S3 using the `S3Hook` from the
`apache-airflow-providers-amazon` package.

```python
from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.providers.amazon.aws.hooks.s3 import S3Hook
from airflow.operators.python import PythonOperator

def upload_to_s3():
    hook = S3Hook(aws_conn_id='aws_default')
    hook.load_string(
        string_data="This is test data",
        key="test_folder/test_file.txt",
        bucket_name="my-s3-bucket",
        replace=True
    )

with DAG(
    dag_id="example_s3_provider_dag",
    start_date=days_ago(1),
    schedule="@daily",
    catchup=False,
) as dag:

    upload_task = PythonOperator(
        task_id="upload_to_s3",
        python_callable=upload_to_s3,
    )
```

### Step 4: Listing Installed Providers
```bash
airflow providers list
```



https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html#declaring-a-dag


1) Make sure correct folder set in airflow.cfg file
dags_folder = /home/ksl/code/airflow-vscode-docker-310/dags/

2) Make sure example dags are disabled,# Whether to load the built-in Airflow example DAGs
Step 1:
[core]
load_examples = False

Step 2: (Optional) Set via environment variable in .env file, Instead of editing airflow.cfg, you can export an environment variable:
export AIRFLOW__CORE__LOAD_EXAMPLES=False

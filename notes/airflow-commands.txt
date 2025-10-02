>>>>>>Database Commands
| Command              | Example               | What it does                                                                                                                  |
| -------------------- | --------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `airflow db init`    | `airflow db init`     | Initializes the Airflow metadata database. Creates tables, default connections, and roles.                                    |
| `airflow db reset`   | `airflow db reset -y` | Drops and recreates the metadata database. All DAG run history, users, and connections are lost. `-y` confirms automatically. |
| `airflow db upgrade` | `airflow db upgrade`  | Applies any pending migrations after upgrading Airflow.                                                                       |
| `airflow db check`   | `airflow db check`    | Checks the health of the Airflow database connection.                                                                         |


>>>>>>>Webserver Commands
| Command                       | Example                                     | What it does                                                            |
| ----------------------------- | ------------------------------------------- | ----------------------------------------------------------------------- |
| `airflow webserver`           | `airflow webserver --port 8080`             | Starts the Airflow UI webserver on specified port.                      |
| `airflow webserver --workers` | `airflow webserver --port 8080 --workers 4` | Starts webserver with multiple worker processes (useful for high load). |



>>>>>>>Scheduler Commands
| Command             | Example                             | What it does                                                                                  |
| ------------------- | ----------------------------------- | --------------------------------------------------------------------------------------------- |
| `airflow scheduler` | `airflow scheduler`                 | Starts the Airflow scheduler, which monitors DAGs and triggers tasks when conditions are met. |
| `airflow jobs list` | `airflow jobs list --state running` | Lists all scheduler jobs, filtered by state.                                                  |


>>>>>>>DAG Commands
| Command                | Example                              | What it does                                                |
| ---------------------- | ------------------------------------ | ----------------------------------------------------------- |
| `airflow dags list`    | `airflow dags list`                  | Lists all DAGs available in the DAG folder.                 |
| `airflow dags trigger` | `airflow dags trigger hello_world`   | Manually triggers a DAG run.                                |
| `airflow dags pause`   | `airflow dags pause hello_world`     | Pauses a DAG (scheduler will not trigger it automatically). |
| `airflow dags unpause` | `airflow dags unpause hello_world`   | Resumes a paused DAG.                                       |
| `airflow dags show`    | `airflow dags show hello_world`      | Displays a DAG’s structure in the terminal.                 |
| `airflow dags delete`  | `airflow dags delete hello_world -y` | Deletes all runs and metadata of the DAG.                   |

>>>>>>>Task Commands
| Command               | Example                                                                               | What it does                                                                 |
| --------------------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| `airflow tasks list`  | `airflow tasks list hello_world`                                                      | Lists all tasks in a DAG.                                                    |
| `airflow tasks test`  | `airflow tasks test hello_world task1 2025-09-28`                                     | Executes a single task instance for testing, without recording it in the DB. |
| `airflow tasks run`   | `airflow tasks run hello_world task1 2025-09-28`                                      | Runs a task instance and records it in the database.                         |
| `airflow tasks clear` | `airflow tasks clear hello_world task1 --start-date 2025-09-28 --end-date 2025-09-28` | Clears task state to allow re-run.                                           |

>>>>>>>Connections and Variables
| Command                      | Example                                                                            | What it does                             |
| ---------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------- |
| `airflow connections list`   | `airflow connections list`                                                         | Lists all connections stored in Airflow. |
| `airflow connections add`    | `airflow connections add my_postgres --conn-uri postgres://user:pass@host:5432/db` | Adds a new connection.                   |
| `airflow connections delete` | `airflow connections delete my_postgres`                                           | Deletes a connection.                    |
| `airflow variables list`     | `airflow variables list`                                                           | Lists all Airflow variables.             |
| `airflow variables set`      | `airflow variables set my_var 123`                                                 | Sets a variable value.                   |
| `airflow variables get`      | `airflow variables get my_var`                                                     | Retrieves a variable value.              |
| `airflow variables delete`   | `airflow variables delete my_var`                                                  | Deletes a variable.                      |


>>>>>>>Users (RBAC) Commands
| Command                | Example                                                                                                          | What it does                           |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| `airflow users create` | `airflow users create --username admin --firstname Admin --lastname User --role Admin --email admin@example.com` | Creates a new user for the Airflow UI. |
| `airflow users list`   | `airflow users list`                                                                                             | Lists all users.                       |
| `airflow users delete` | `airflow users delete --username admin`                                                                          | Deletes a user.                        |


>>>>>>>Info and Help Commands
| Command                    | Example                                  | What it does                                                                                             |
| -------------------------- | ---------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| `airflow info`             | `airflow info`                           | Displays full environment info: Airflow home, config file, executor, DB connection, Python version, etc. |
| `airflow version`          | `airflow version`                        | Shows the current Airflow version.                                                                       |
| `airflow config list`      | `airflow config list`                    | Shows all configuration options.                                                                         |
| `airflow config get-value` | `airflow config get-value core executor` | Gets a specific config value.                                                                            |
| `airflow help`             | `airflow help`                           | Lists all available Airflow CLI commands.                                                                |


>>>>>>>Examples for a Project Workflow

# Initialize DB
airflow db init

# Create an admin user
airflow users create --username admin --firstname Admin --lastname User --role Admin --email admin@example.com

# List all DAGs
airflow dags list

# Trigger a DAG
airflow dags trigger example_dag

# View tasks in a DAG
airflow tasks list example_dag

# Test a single task (without recording in DB)
airflow tasks test example_dag task1 2025-09-28

# Start scheduler
airflow scheduler

# Start webserver on port 8080
airflow webserver --port 8080

# Check current Airflow environment info
airflow info

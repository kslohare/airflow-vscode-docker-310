# Airflow Commands Guide

## 1. Virtual Environment

### Activate Virtual Environment
```bash
cd /home/ksl/code/airflow-vscode-docker-310
source .venv/bin/activate
```

### Inactive virtual env
```
deactivate
```

### Start-Stop Services
```
airflow api-server --port 9001 -D #Run the API server on port 9001

airflow scheduler -D # Start the scheduler

airflow dag-processor -D # Start DAG processor
OR
AIRFLOW__CORE__LOGGING_LEVEL=DEBUG airflow dag-processor
OR
airflow dag-processor -v

airflow triggerer -D
```

#### Open Airflow UI -Visit:
http://localhost:9001

ps -aux | grep -i airflow

## Stop
pkill -f "airflow api_server"

pkill -f "airflow scheduler"

          OR

ps aux | grep -i 'airflow api_server'

ps aux | grep -i 'airflow scheduler'

ps aux | grep -i 'airflow dag-processor'

kill -9 ddd
kill -9 dd

          OR - Not working in 3.x

airflow api-server --stop

airflow scheduler --stop
```

###

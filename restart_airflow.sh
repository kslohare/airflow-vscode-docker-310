#!/bin/bash

echo "Deleting log files..."
rm /home/ksl/code/airflow-vscode-docker-310/airflow_home/airflow-api_server.err
rm /home/ksl/code/airflow-vscode-docker-310/airflow_home/airflow-api_server.out
rm /home/ksl/code/airflow-vscode-docker-310/airflow_home/airflow-api_server.pid
rm /home/ksl/code/airflow-vscode-docker-310/airflow_home/airflow-dag-processor.err
rm /home/ksl/code/airflow-vscode-docker-310/airflow_home/airflow-dag-processor.log
rm /home/ksl/code/airflow-vscode-docker-310/airflow_home/airflow-dag-processor.out
rm /home/ksl/code/airflow-vscode-docker-310/airflow_home/airflow-scheduler.err
rm /home/ksl/code/airflow-vscode-docker-310/airflow_home/airflow-scheduler.log
rm /home/ksl/code/airflow-vscode-docker-310/airflow_home/airflow-scheduler.out

echo "Stopping Airflow processes..."

# Kill API server if running
if [ -f "$AIRFLOW_HOME/airflow-api_server.pid" ]; then
    pid=$(cat "$AIRFLOW_HOME/airflow-api_server.pid")
    echo "Stopping API server with PID $pid..."
    kill -9 $pid 2>/dev/null || true
    echo "$? ... stoped airflow-api_server ?"
    rm -f "$AIRFLOW_HOME/airflow-api_server.pid"
fi

# Kill Scheduler if running
if [ -f "$AIRFLOW_HOME/airflow-scheduler.pid" ]; then
    pid=$(cat "$AIRFLOW_HOME/airflow-scheduler.pid")
    echo "Stopping Scheduler with PID $pid..."
    kill -9 $pid 2>/dev/null || true
    echo "$? ... stoped airflow-scheduler ?"
    rm -f "$AIRFLOW_HOME/airflow-scheduler.pid"
fi

# Kill Dag Processor if running
pgrep -f "airflow.dag_processing" | xargs -r kill -9
echo "$? ... stoped airflow.dag_processing ?"

sleep 2

echo "Starting Airflow processes..."

# Start API server on port 9001
airflow api-server --port 9001 -D

# Start Scheduler
airflow scheduler -D

# Start Dag Processor
airflow dag-processor -D

echo "Airflow restarted successfully."

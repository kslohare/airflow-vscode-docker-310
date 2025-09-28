#!/bin/bash

# Get current timestamp
timestamp=$(date +"%Y-%m-%d %H:%M:%S")


# Append versions info to the file with timestamp
(
  echo "===== $timestamp ====="
  echo "=== Python Version ==="
  python --version
  echo ""
  echo "=== Airflow Version ==="
  airflow version
  echo ""
  echo "=== Airflow Info ==="
  airflow info
  echo ""
) > current_versions.txt

echo "Saved current versions with timestamp to current_versions.txt"

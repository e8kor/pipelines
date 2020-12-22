#!/bin/bash

[[ -z "$AIRFLOW__CORE__FERNET_KEY" ]] && { echo "Fernet key for AIRFLOW__CORE__FERNET_KEY is not defined"; exit 1; }

airflow initdb
airflow scheduler &
exec airflow webserver

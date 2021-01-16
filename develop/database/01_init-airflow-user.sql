DO
$do$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_catalog.pg_database
        WHERE  dbname = 'airflow') THEN
        CREATE DATABASE airflow;
    END IF;
END
$do$;


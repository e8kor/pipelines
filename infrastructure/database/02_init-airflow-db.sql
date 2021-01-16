CREATE DATABASE airflow;
DO
$do$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_catalog.pg_roles
        WHERE  rolname = 'airflow') THEN

        CREATE USER airflow WITH PASSWORD 'airflow';
        GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;
    END IF;
END
$do$;


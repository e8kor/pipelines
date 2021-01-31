DO
$do$
BEGIN
   IF NOT EXISTS (SELECT * FROM pg_user WHERE pg_user.usename = 'airflow') THEN
      CREATE USER airflow WITH PASSWORD 'airflow';
    GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;
   END IF;
END
$do$;
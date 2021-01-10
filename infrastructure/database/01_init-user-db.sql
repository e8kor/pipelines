CREATE TABLE IF NOT EXISTS schemas (			
    created        timestamp NOT NULL,	
    schema_group   varchar   NOT NULL,		
    schema_name    varchar   NOT NULL,		
    schema_version varchar   NOT NULL,	
    data           json      NOT NULL,
    PRIMARY KEY (schema_group, schema_name, schema_version)		
);		

CREATE SEQUENCE IF NOT EXISTS otodomserial;

CREATE TABLE IF NOT EXISTS otodom (
    ID INT PRIMARY KEY NOT NULL DEFAULT NEXTVAL('otodomserial'),
    created timestamp NOT NULL,
    data           json    NOT NULL
);

COMMIT;

-- INSERT INTO testv3(created, data) VALUES 
--     (TO_TIMESTAMP('2020-12-31 20:43:33.52 +0000 UTC m=+64.899146112'), '{ "entry": "test"}');

-- DROP SEQUENCE IF EXISTS testserial;
-- DROP TABLE IF EXISTS test
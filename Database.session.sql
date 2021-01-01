-- CREATE TABLE IF NOT EXISTS test (
--     ID INT PRIMARY KEY     NOT NULL,
--     domain VARCHAR NOT NULL,
--     data           json    NOT NULL
-- )
--DROP TABLE IF EXISTS test

CREATE if not EXISTS test (
    ID INT PRIMARY KEY     NOT NULL,
    domain VARCHAR NOT NULL,
    data           json    NOT NULL
)CREATE TABLE IF NOT EXISTS testv2 (
    ID INT PRIMARY KEY     NOT NULL,
    created timestamp NOT NULL,
    data           json    NOT NULL
)


INSERT INTO testv2 (created, data) VALUES ( ("2020-12-31 20:43:33.691767036 +0000 UTC m=+64.899146112", "{ 'entry': 'test'}") )
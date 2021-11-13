CREATE TABLE IF NOT EXISTS pending (
    id SERIAL PRIMARY KEY,
    latitude FLOAT,
    longitude FLOAT,
    description VARCHAR,
    photo VARCHAR
);
CREATE TABLE IF NOT EXISTS locations (
    id SERIAL PRIMARY KEY,
    latitude FLOAT,
    longitude FLOAT,
    description VARCHAR,
    photo VARCHAR
);

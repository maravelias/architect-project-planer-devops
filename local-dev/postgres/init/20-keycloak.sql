-- Keycloak persistence database (runs on first Postgres init only)
CREATE USER keycloak WITH PASSWORD 'keycloak';
CREATE DATABASE keycloak OWNER keycloak;
GRANT ALL PRIVILEGES ON DATABASE keycloak TO keycloak;

-- Force SSL to 'none' for all realms when they are created/updated.
-- Note: This is a hack for local development to ensure we don't get locked out of master realm.
-- Since Keycloak might create tables later, this script might need to be run after Keycloak starts,
-- but we can try to add a trigger or just suggest the manual SQL command.

/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;
CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name varchar(100) Not NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10,2));

-- ADD species column in animals table 
ALTER TABLE animals
ADD species VARCHAR(50);
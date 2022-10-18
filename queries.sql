/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/01/01';
SELECT * FROM animals WHERE neutered = true AND escape_attempts <3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg >10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';
SELECT * FROM animals WHERE wight_kg >=10.4 AND wight_kg <=17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
COMMIT;
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals SET species = 'pikemon' WHERE name NOT LIKE '%mon';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name NOT  LIKE '%mon';
SELECT * FROM animals;
COMMIT;
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK; 
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022/01/01';
DELETE 1
SELECT * FROM animals;
SAVEPOINT my_savepoint1;
UPDATE animals SET wight_kg = wight_kg*-1;
ROLLBACK TO SAVEPOINT my_savepoint1;
UPDATE animals SET wight_kg = wight_kg*-1 WHERE wight_kg < 0;

SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts =0;
SELECT AVG(wight_kg) FROM animals;
SELECT name  FROM animals WHERE escape_attempts = ( SELECT MAX (escape_attempts) FROM animals WHERE neutered = true OR neutered = false );
SELECT species, MAX(wight_kg) FROM animals GROUP BY species; 
SELECT species, MAX(wight_kg), MIN(wight_kg) FROM animals GROUP BY species; 
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/01/01' GROUP BY species;

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
SELECT * FROM animals;
SAVEPOINT my_savepoint1;
UPDATE animals SET wight_kg = wight_kg*-1;
ROLLBACK TO SAVEPOINT my_savepoint1;
UPDATE animals SET wight_kg = wight_kg*-1 WHERE wight_kg < 0;
COMMIT;
SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts =0;
SELECT AVG(wight_kg) FROM animals;
SELECT name  FROM animals WHERE escape_attempts = ( SELECT MAX (escape_attempts) FROM animals WHERE neutered = true OR neutered = false );
SELECT species, MAX(wight_kg) FROM animals GROUP BY species; 
SELECT species, MAX(wight_kg), MIN(wight_kg) FROM animals GROUP BY species; 
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/12/31' GROUP BY species;
SELECT name, full_name FROM animals JOIN owners ON owner_id = 4 AND full_name = 'Melody Pond';
SELECT A.name, S.name FROM animals A JOIN species S ON A.species_id =1 AND S.name ='Pokemon';
SELECT A.name, O.full_name  FROM animals A FULL JOIN owners O ON A.owner_id = O.id;
SELECT S.name, COUNT(species_id)  FROM animals A JOIN species S ON A.species_id = S.id GROUP BY S.name;

SELECT
        *
FROM (
        SELECT
                owners.full_name as owner,
                COUNT(*) count_animals
        FROM
                animals
                RIGHT JOIN owners ON owners.id = animals.owner_id
        GROUP BY
                owners.full_name
) AS count_animals_per_owner
WHERE
        count_animals_per_owner.count_animals = (
                SELECT
                        MAX(count_per_species)
                FROM (
                        SELECT
                                owners.full_name as owner,
                                COUNT(*) count_per_species
                        FROM
                                animals
                                RIGHT JOIN owners ON owners.id = animals.owner_id
                        GROUP BY
                                owners.full_name
                ) AS count_animals_per_owner
        );

        // question 1
SELECT vets.name, animals.name, visits.visiting_date FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Vet William Tatcher' ORDER BY visiting_date DESC LIMIT 1;
        // question 2
SELECT COUNT(DISTINCT (animals.name)), vets.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name LIKE 'Vet Stephene Mendez'
GROUP BY vets.name;

        // question 3
SELECT vets.name, species.name FROM vets
LEFT JOIN species ON vets.id = species.id;
        // question 4
 SELECT animals.name, vets.name, visits.visiting_date FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Vet Stephanie Mendez' AND visiting_date BETWEEN DATE '2020-04-01' AND '2020-08-30';
        // question 5
SELECT COUNT(animals.name), animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vets_id
GROUP BY animals.name
ORDER BY count DESC LIMIT 1;
        // question 6
SELECT animals.name, visits.visiting_date FROM animals
JOIN visits ON animals.id = visits.animal_id
ORDER BY visits.visiting_date LIMIT 1;
        // question 7
SELECT animals.*, vets.*, visits.visiting_date FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vets_id
ORDER BY visiting_date DESC LIMIT 1;
        // question 8
SELECT vets.name, COUNT(vets.name) FROM vets
LEFT JOIN spevialization ON spevialization.vets_id = vets.id
LEFT JOIN visits ON vets.id = visits.vets_id
LEFT JOIN species ON species.id = spevialization.species_id
GROUP BY vets.name;

        // question 9
        SELECT COUNT(*) FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vets_id 
LEFT JOIN spevialization ON spevialization.vets_id = vets.id 
WHERE spevialization.species_id != animals.species_id OR spevialization.species_id is NULL;

        // question 10
SELECT species.name, count(*) FROM visits 
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets_id=2
GROUP BY species.name LIMIT 1;


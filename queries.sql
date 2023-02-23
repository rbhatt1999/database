/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016/01/01' and '2019/12/31';
SELECT name from animals WHERE neutered = TRUE and escape_attempts < 3;
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name =  'Pikachu' ;
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = TRUE;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- setting the species column to unspecified
BEGIN; -- start transaction

UPDATE animals SET species = 'unspecified';

-- Verify that change was made
SELECT * FROM animals;

-- Then roll back the change
ROLLBACK;

-- verify that species columns went back to the state before transaction.
SELECT * FROM animals;

/* Adding animal species*/

BEGIN; -- start transaction

-- setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- setting the species column to pokemon for all animals that don't have species already set.
Update animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT; --Commit the transaction.

-- Verify that change was made and persists after commit.
SELECT * FROM animals;

/* Deleting all animal*/
BEGIN;

DELETE FROM animals;

-- verify that the animals have been deleted
SELECT * FROM animals;

ROLLBACK;

-- very that table content are present
SELECT * FROM animals;

-- savepoint
BEGIN;

DELETE FROM animals WHERE date_of_birth > '2020-01-01';

SAVEPOINT s1;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO s1;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth 
BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/*Write queries (using JOIN) to answer the following questions*/

-- What animals belong to Melody Pond?
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT * FROM animals a INNER JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM owners o FULL OUTER JOIN animals a ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT s.name, COUNT(*) FROM species s LEFT JOIN animals a ON s.id =  a.species_id GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Jennifer Orwell' 
  AND a.species_id = (SELECT id from species WHERE name = 'Digimon');

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' 
AND a.escape_attempts <= 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(*) FROM owners o LEFT JOIN animals a ON o.id =  a.owner_id GROUP BY o.full_name
ORDER BY COUNT DESC LIMIT 1;

SELECT vets.name, date_of_visit, animals.name FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;
SELECT species.name FROM specializations s JOIN vets ON s.vet_id = vets.id JOIN visits ON visits.vet_id = vets.id JOIN species ON s.species_id = species.id WHERE vets.name = 'Stephanie Mendez' GROUP BY species.name;
SELECT vets.name AS vet_name, sp.name AS sp_name FROM vets FULL JOIN specializations s ON s.vet_id = vets.id LEFT JOIN species sp ON s.species_id = sp.id;
SELECT vt.name AS vet_name, a.name AS ani_name, date_of_visit FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
SELECT name, COUNT(date_of_birth) FROM animals a JOIN visits v ON a.id = v.animal_id GROUP BY a.name ORDER BY count DESC LIMIT 1;
SELECT a.name, vt.name, date_of_visit FROM visits v JOIN vets vt ON v.vet_id = vt.id JOIN animals a ON v.animal_id = a.id WHERE vt.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;
SELECT a.name AS ani_name, vt.name AS vet_name, date_of_visit FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id ORDER BY date_of_visit DESC LIMIT 1;
SELECT COUNT(sp.name), sp.name FROM visits v JOIN animals a ON v.animal_id = a.id JOIN species sp ON a.species_id = sp.id JOIN vets vt ON v.vet_id = vt.id WHERE vet_id = 2 GROUP BY(sp.name) limit 1;
SELECT COUNT(*) AS species FROM visits v FULL OUTER JOIN vets vt ON v.vet_id = vt.id FULL OUTER JOIN specializations s ON s.vet_id = vt.id WHERE species_id IS NULL;
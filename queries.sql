/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*Added species*/

BEGIN;

UPDATE animals SET species='unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species IS NULL;

SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;

/*Delete record*/

BEGIN;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

/*Change weight*/

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT animals_savepoint;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO animals_savepoint;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

/*Aggregate*/

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT name FROM animals ani JOIN owners own ON ani.owner_id = own.id WHERE own.full_name = 'Melody Pond';
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;
SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
SELECT animals.name FROM animals
	JOIN species ON animals.species_id = species.id
	JOIN owners ON animals.owner_id = owners.id
	WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
SELECT animals.name FROM animals
	JOIN owners ON animals.owner_id = owners.id
	WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT owners.full_name, COUNT(animals.owner_id) AS animal_count FROM animals
	JOIN owners ON animals.owner_id = owners.id
	GROUP BY owners.id
	ORDER BY animal_count DESC
	LIMIT 1;

SELECT animals.name
	FROM animals
	JOIN visits ON visits.animal_id = animals.id
	WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Vet William Tatcher')
	ORDER BY visits.visit_date DESC
	LIMIT 1;
SELECT COUNT(DISTINCT visits.animal_id)
	FROM visits
	JOIN vets ON vets.id = visits.vet_id
	WHERE vets.name = 'Vet Stephanie Mendez';
SELECT vets.name, COALESCE(species.name, 'None') AS specialization
	FROM vets
	LEFT JOIN specializations ON specializations.vet_id = vets.id
	LEFT JOIN species ON species.id = specializations.species_id
	ORDER BY vets.name;
SELECT animals.name
	FROM animals
	JOIN visits ON animals.id = visits.animal_id
	WHERE visits.vet_id = 3 AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';
SELECT animals.name, COUNT(*) AS num_visits
	FROM animals
	JOIN visits ON visits.animal_id = animals.id
	GROUP BY animals.id
	ORDER BY num_visits DESC
	LIMIT 1;
SELECT animals.name
	FROM animals
	JOIN visits ON visits.animal_id = animals.id
	JOIN vets ON vets.id = visits.vet_id
	WHERE vets.name = 'Vet Maisy Smith'
	ORDER BY visits.visit_date
	LIMIT 1;
SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, vets.name, vets.age, vets.date_of_graduation, visits.visit_date
	FROM visits
	JOIN animals ON animals.id = visits.animal_id
	JOIN vets ON vets.id = visits.vet_id
	ORDER BY visits.visit_date DESC
	LIMIT 1;
SELECT vets.name AS vet_name,
	COUNT(visits.animal_id) AS numbers_of_visits
	FROM visits
	JOIN vets ON visits.vet_id = vets.id
	JOIN animals ON animals.id = visits.animal_id
	FULL JOIN specializations ON visits.vet_id = specializations.vet_id
	GROUP BY visits.animal_id, vets.name
	ORDER BY COUNT(visits.animal_id) DESC
	LIMIT 1;
SELECT species.name AS species_name, vets.name AS vet_name, COUNT(*) AS numbers_of_visits
	FROM vets
	JOIN visits ON vets.id = visits.vet_id
	JOIN animals ON animals.id = visits.animal_id
	JOIN species ON species.id = animals.species_id
	WHERE vets.name = 'Vet Maisy Smith'
	GROUP BY species.name, vets.name
	ORDER BY COUNT(*) DESC
	LIMIT 1;

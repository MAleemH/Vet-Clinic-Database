/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, TRUE, 11);

/* Updated data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, FALSE, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, TRUE, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, FALSE, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, TRUE, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, TRUE, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, TRUE, 22);

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

UPDATE animals SET species_id = 
    CASE 
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END;

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation) VALUES ('Vet William Tatcher', 45, '2000-04-23'), ('Vet Maisy Smith', 26, '2019-01-17'), ('Vet Stephanie Mendez', 64, '1981-05-04'), ('Vet Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
	SELECT vets.id, species.id
	FROM vets, species
	WHERE vets.name = 'Vet William Tatcher'
	AND species.name = 'Pokemon';
INSERT INTO specializations (vet_id, species_id)
	SELECT vets.id, species.id
	FROM vets, species
	WHERE vets.name = 'Vet Stephanie Mendez'
	AND species.name IN ('Digimon', 'Pokemon');
INSERT INTO specializations (vet_id, species_id)
	SELECT vets.id, species.id
	FROM vets, species
	WHERE vets.name = 'Vet Jack Harkness'
	AND species.name = 'Digimon';

INSERT INTO visits (animal_id, vet_id, visit_date)
	SELECT animals.id, vets.id, '2020-05-24'
	FROM animals, vets
	WHERE animals.name = 'Agumon'
	AND vets.name = 'Vet William Tatcher';
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),
	'2020-07-22'
);
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (
    	(SELECT id FROM animals WHERE name = 'Gabumon'),
    	(SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),
		'2021-02-02'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Pikachu'),
    	(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
		'2020-01-05'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Pikachu'),
    	(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
		'2020-03-08'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Pikachu'),
    	(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
		'2020-05-14'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Devimon'),
    	(SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),
		'2021-05-04'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Charmander'),
    	(SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),
		'2021-02-24'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Plantmon'),
    	(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
		'2019-12-21'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Plantmon'),
    	(SELECT id FROM vets WHERE name = 'Vet William Tatcher'),
		'2020-08-10'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Plantmon'),
    	(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
		'2021-04-07'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Squirtle'),
    	(SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),
		'2019-09-29'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Angemon'),
    	(SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),
		'2020-10-03'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Angemon'),
    	(SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),
		'2020-11-04'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Boarmon'),
    	(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
		'2019-01-24'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Boarmon'),
    	(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
		'2019-05-15'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Boarmon'),
    	(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
		'2020-02-27'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Boarmon'),
    	(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),
		'2020-08-03'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Blossom'),
    	(SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),
		'2020-05-24'
	),
	(
    	(SELECT id FROM animals WHERE name = 'Blossom'),
    	(SELECT id FROM vets WHERE name = 'Vet William Tatcher'),
		'2021-01-11'
	);


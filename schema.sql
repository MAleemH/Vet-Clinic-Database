/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

CREATE TABLE owners (
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(255),
	age INT,
	PRIMARY KEY (id)
);

CREATE TABLE species (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255),
	PRIMARY KEY (id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255),
	age INT,
	date_of_graduation DATE,
	PRIMARY KEY(id)
);

CREATE TABLE specializations (
	vet_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id)
);

CREATE TABLE visits (
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    visit_date DATE
);

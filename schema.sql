/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
    id INT, 
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INT, 
    neutered BOOLEAN, 
    wight_kg DECIMAL,
    PRIMARY KEY(id)
    );
ALTER TABLE animals ADD COLUMN species VARCHAR(250);
CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY, full_name VARCHAR(250), age INT, PRIMARY KEY(id));
CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(250), PRIMARY KEY(id));
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species (id);
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners (id);

CREATE TABLE vets (id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(250), age INT, date_of_graduation DATE, PRIMARY KEY(id));

CREATE TABLE spevialization (species_id INT, vets_id INT, PRIMARY KEY (species_id, vets_id),
  CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
  CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id) 
);
CREATE TABLE visits( animal_id INT, vets_id INT,visiting_date DATE,
  PRIMARY KEY (animal_id, vets_id, visiting_date),
  CONSTRAINT fk_animals FOREIGN KEY(animal_id) REFERENCES animals(id),
  CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id)
);





/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)  VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)  VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)  VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)  VALUES ('Devimon', '2017-05-12', 5, TRUE, 11);

-- ADD NEW DATA TO ANIMAL TABLE

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Charmander', 
        '2020-02-08', 
        0, 
        false, 
        -11);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Plantmon', 
        '2021-11-15', 
        2, 
        true, 
        -5.7);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Squirtle', 
        '1993-04-02', 
        3, 
        false, 
        -12.13);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Angemon', 
        '2005-06-12', 
        1, 
        true, 
        -45);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Boarmon', 
        '2005-06-07', 
        7, 
        true, 
        20.4);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Blossom', 
        '1998-10-13', 
        3, 
        true, 
        17);

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg) 
    VALUES (
        'Ditto', 
        '2022-05-14', 
        4, 
        true, 
        22);

/*Insert the following data into the owners table*/

INSERT INTO owners (
    full_name, 
    age) 
    VALUES (
        'Sam Smith', 
        34);

INSERT INTO owners (
    full_name, 
    age) 
    VALUES (
        'Jennifer Orwell',
         19);

INSERT INTO owners (
    full_name, 
    age) 
    VALUES (
        'Bob',
         45);

INSERT INTO owners (
    full_name, 
    age) 
    VALUES (
        'Melody Pond',
         77);

INSERT INTO owners (
    full_name, 
    age) 
    VALUES (
        'Dean Winchester',
         14);

INSERT INTO owners (
    full_name, 
    age) 
    VALUES (
        'Jodie Whittaker',
         38);

/*Insert the following data into the species table*/
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

/*Modify your inserted animals so it includes the species_id value*/
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id is NULL;


/*Modify your inserted animals to include owner information (owner_id)*/
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') 
WHERE name = 'Agumon';

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') 
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') 
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') 
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') 
WHERE name IN ('Angemon', 'Boarmon');

-- Inserting data into vets table
INSERT INTO vets (
    name, 
    age, 
    date_of_graduation)
  VALUES (
      'William Tatcher', 
      45, 
      '2000-04-23');

INSERT INTO vets (
    name, 
    age, 
    date_of_graduation)
    VALUES (
        'Maisy Smith', 
        26, 
        '2019-01-17');

INSERT INTO vets (
    name, 
    age, 
    date_of_graduation)
    VALUES (
        'Stephanie Mendez', 
        64, 
        '1981-05-04');

INSERT INTO vets (
    name, 
    age, 
    date_of_graduation)   
    VALUES (
        'Jack Harkness', 
        38, 
        '2008-06-08');

-- Inserting data into Specializations table
INSERT INTO 
  specializations
    (species_id, vet_id)
  VALUES (
    (
      SELECT id 
      FROM species 
      WHERE name = 'Pokemon'
    ),
    (
      SELECT id 
      FROM vets 
      WHERE name = 'William Tatcher'
    )
  );

INSERT INTO 
  specializations
    (species_id, vet_id)
  VALUES 
    (
      (
        SELECT id 
        FROM species 
        WHERE name = 'Pokemon'
      ),
      (
        SELECT id 
        FROM vets 
        WHERE name = 'Stephanie Mendez'
      )
    ),
    (
      (
        SELECT id 
        FROM species 
        WHERE name = 'Digimon'
      ),
      (
        SELECT id 
        FROM vets 
        WHERE name = 'Stephanie Mendez'
      )
    );

INSERT INTO 
  specializations
    (species_id, vet_id)
  VALUES (
    (
      SELECT id 
      FROM species 
      WHERE name = 'Digimon'
    ),
    (
      SELECT id 
      FROM vets 
      WHERE name = 'Jack Harkness'
    )
  );

-- Insert data for visits
INSERT INTO
  visits
    (animal_id, vet_id,  date_of_visit)
  VALUES 
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Agumon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'William Tatcher'
      ),
      '2020-05-24'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Agumon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      '2020-07-22'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Gabumon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      '2021-02-02'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Pikachu'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2020-01-05'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Pikachu'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2020-03-08'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Pikachu'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2020-05-14'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Devimon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      '2021-05-04'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Charmander'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      '2021-02-24'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Plantmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2019-12-21'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Plantmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'William Tatcher'
      ),
      '2020-08-10'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Plantmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2021-04-07'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Squirtle'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      '2019-09-29'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Angemon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      '2020-10-03'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Angemon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      '2020-11-04'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2019-01-24'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2019-05-15'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2020-02-27'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      '2020-08-03'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Blossom'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      '2020-05-24'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Blossom'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'William Tatcher'
      ),
      '2021-01-11'
    );

    -- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
SELECT * FROM (SELECT id FROM animals) animal_ids, 
(SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') 
visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) 
select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
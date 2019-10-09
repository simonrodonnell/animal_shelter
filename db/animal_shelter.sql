DROP TABLE adoptions;
DROP TABLE owners;
DROP TABLE animals;
DROP TABLE animal_types;

CREATE TABLE owners
(
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  age INT2,
  address VARCHAR(255)
);

CREATE TABLE animal_types
(
  id SERIAL8 PRIMARY KEY,
  species VARCHAR(255)
);

CREATE TABLE animals
(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  age INT2,
  admission_date DATE,
  is_adoptable BOOLEAN,
  photo VARCHAR(255),
  animal_type_id INT8 REFERENCES animal_types(id) ON DELETE CASCADE
);

CREATE TABLE adoptions
(
  id SERIAL8 PRIMARY KEY,
  owner_id INT8 REFERENCES owners(id) ON DELETE CASCADE,
  animal_id INT8 REFERENCES animals(id) ON DELETE CASCADE
)

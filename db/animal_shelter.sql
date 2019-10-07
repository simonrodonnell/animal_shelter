DROP TABLE adoptions;
DROP TABLE animals;
DROP TABLE owners;

CREATE TABLE owners
(
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  age INT2,
  address VARCHAR(255)
);

CREATE TABLE animals
(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  age INT2,
  species VARCHAR(255),
  admission_date VARCHAR(255),
  is_adoptable BOOLEAN
);

CREATE TABLE adoptions
(
  id SERIAL8 PRIMARY KEY,
  owner_id INT8 REFERENCES owners(id) ON DELETE CASCADE,
  animal_id INT8 REFERENCES animals(id) ON DELETE CASCADE
)

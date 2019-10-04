DROP TABLE animals;
DROP TABLE owners;

CREATE TABLE owners (
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
);

CREATE TABLE animals (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  age INT2,
  species VARCHAR(255),
  admission_date VARCHAR(255),
  adoptable BOOLEAN,
  owner_id INT8 REFERENCES owners(id)
);

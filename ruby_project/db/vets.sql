DROP TABLE customers;
DROP TABLE pets;
DROP TABLE vets;

CREATE TABLE vets (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  specialism VARCHAR(255)
);

CREATE TABLE customers(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  appointment VARCHAR(255),
  contact_details VARCHAR(255)
);


CREATE TABLE pets(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  dob VARCHAR(255),
  type_of_animal VARCHAR(255),
  treatment_notes VARCHAR(255),
  vet_id INT8 REFERENCES vets(id) ON DELETE CASCADE,
  customer_id INT8 REFERENCES customers(id) ON DELETE CASCADE
);

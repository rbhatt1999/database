CREATE TABLE patients (
  id SERIAL,
  name VARCHAR(100),
  date_of_birth date,
  PRIMARY KEY(id)
);
CREATE TABLE medical_histories(
  id SERIAL PRIMARY KEY,
  admited_at TIMESTAMP,
  patient_id INT,
  status VARCHAR,
  CONSTRAINT fk_patient_id FOREIGN KEY(patient_id) REFERENCES patients(id)
);
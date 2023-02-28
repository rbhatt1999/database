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

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  CONSTRAINT fk_medical_history_id FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)
);
CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR,
  name VARCHAR
);

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoice_id FOREIGN KEY(invoice_id) REFERENCES invoices(id),
  CONSTRAINT fk_treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  deleted_at TIMESTAMPTZ NULL
);

CREATE TABLE banks (
  id INT PRIMARY KEY,
  bank_name VARCHAR(50) NOT NULL
);

CREATE TABLE deadline(
  id INT PRIMARY KEY,
  deadline VARCHAR(50) NOT NULL
);
CREATE TABLE payment(
  id INT PRIMARY KEY,
  amount INT,
  amount_limit INT
);

CREATE TABLE companies (
  id SERIAL PRIMARY KEY,
  bank_id INT NOT NULL REFERENCES banks (id),
  bill_id INT NOT NULL REFERENCES bills (id),
  payment_id INT NOT NULL REFERENCES payment (id),
  deadline_id INT NOT NULL REFERENCES deadlne (id),
  company_name VARCHAR(255) NOT NULL,
  phone_num INT NOT NULL,
  create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE bills (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies (id),
  is_paid BOOLEAN DEFAULT FALSE NOT NULL,
  memo TEXT,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMPTZ NULL
);

CREATE INDEX idx_bills_unpaid_created_at ON bills (created_at)
WHERE
  is_paid = FALSE
  AND deleted_at IS NULL;

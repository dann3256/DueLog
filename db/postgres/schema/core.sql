CREATE TABLE banks (
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);


CREATE TABLE companies (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255),
  deleted_at TIMESTAMPTZ NULL
);

CREATE TABLE bills (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies (id),
  bank_id INT NOT NULL REFERENCES banks (id),
  amount INT NOT NULL,
  payment_limit INT NOT NULL,
  payment_date VARCHAR(255) NOT NULL,
  paid_at TIMESTAMPTZ,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMPTZ NULL
);

CREATE INDEX idx_bills_unpaid_created_at ON bills (created_at)
WHERE
  is_paid = FALSE
  AND deleted_at IS NULL;

CREATE TABLE banks (
  id INT PRIMARY KEY,
  bank_name VARCHAR(50) NOT NULL
);

CREATE TABLE deadlines (
  id INT PRIMARY KEY,
  payment_date VARCHAR(255) NOT NULL
);

CREATE TABLE companies (
  id SERIAL PRIMARY KEY,
  bank_id INT NOT NULL REFERENCES banks (id),
  payment_deadline_id INT NOT NULL REFERENCES deadlines (id),
  company_name VARCHAR(255) NOT NULL,
  phone_num INT NOT NULL,
  payment_amount INT NOT NULL,
  payment_limit INT NOT NULL,
  create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  deleted_at TIMESTAMPTZ NULL
);

CREATE INDEX idx_users_email ON users (email);

CREATE TABLE bills (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users (id),
  company_id INT NOT NULL REFERENCES companies (id),
  is_paid BOOLEAN DEFAULT FALSE NOT NULL,
  paid_at TIMESTAMPTZ,
  memo TEXT,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMPTZ NULL
);

CREATE INDEX idx_bills_unpaid_created_at ON bills (created_at)
WHERE
  is_paid = FALSE
  AND deleted_at IS NULL;

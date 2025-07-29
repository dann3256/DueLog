CREATE TABLE banks (
  id SERIAL PRIMARY KEY,
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

CREATE TYPE payment_limit_date AS ENUM ('current_month_end', 'next_month_15', 'next_month_20', 'next_month_end');

CREATE TABLE bills (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies (id),
  bank_id INT NOT NULL REFERENCES banks (id),
  amount INT NOT NULL,
  payment_limit INT NOT NULL,
  payment_date payment_limit_date NOT NULL,
  paid_at TIMESTAMPTZ NULL,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMPTZ NULL,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);


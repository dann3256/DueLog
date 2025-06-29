-- enable UUID of PostgreSQL
CREATE EXTENSION IF NOT EXISTS pgcrypto;

--users information 
create table users(
    id  UUID primary key default gen_random_uuid(),
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    deleted_at TIMESTAMPTZ NULL--softdelete
);
-- index
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_deleted_at ON users(deleted_at) WHERE deleted_at IS NOT NULL;

-- autmatic update time 
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';




--bills information
CREATE TABLE bills (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ,
    company_id UUID NOT NULL REFERENCES companys(id),
    amount INT NOT NULL CHECK (amount >= 0),
    due_date DATE NOT NULL,
    is_paid BOOLEAN DEFAULT FALSE,
    paid_at TIMESTAMPTZ NULL,
    memo TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ NULL 
);

--company information
CREATE TABLE companys(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_name  VARCHAR(255) NOT NULL,
    phone_num INT NOT NULL
)

-- index
CREATE INDEX idx_bills_user_id ON bills(user_id);
CREATE INDEX idx_bills_due_date ON bills(due_date);
CREATE INDEX idx_bills_is_paid ON bills(is_paid);
CREATE INDEX idx_bills_user_due_paid ON bills(user_id, due_date, is_paid) WHERE deleted_at IS NULL;
CREATE INDEX idx_bills_deleted_at ON bills(deleted_at) WHERE deleted_at IS NOT NULL;

-- portion index（unpaid）
CREATE INDEX idx_bills_unpaid_due_date ON bills(due_date) 
    WHERE is_paid = FALSE AND deleted_at IS NULL;

-- trigger
CREATE TRIGGER update_bills_updated_at 
    BEFORE UPDATE ON bills 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();




-- paid automatic update
CREATE OR REPLACE FUNCTION set_paid_at()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.is_paid = TRUE AND OLD.is_paid = FALSE THEN
        NEW.paid_at = CURRENT_TIMESTAMP;
    ELSIF NEW.is_paid = FALSE THEN
        NEW.paid_at = NULL;
    END IF;
    RETURN NEW;
END;
$$ language 'plpgsql';

--trigger
CREATE TRIGGER set_bills_paid_at 
    BEFORE UPDATE ON bills 
    FOR EACH ROW EXECUTE FUNCTION set_paid_at();
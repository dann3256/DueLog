
CREATE EXTENSION IF NOT EXISTS pgcrypto;

create table users(
    id  INT,
    username VARCHAR(255) NOT NULL ,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    deleted_at TIMESTAMPTZ NULL
);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_deleted_at ON users(deleted_at) WHERE deleted_at IS NOT NULL;



CREATE TABLE bills (
    id INT,
    user_id UUID NOT NULL REFERENCES users(id) ,
    company_id UUID NOT NULL REFERENCES companies(id),
    amount INT NOT NULL CHECK (amount >= 0),
    due_date DATE NOT NULL,
    is_paid BOOLEAN DEFAULT FALSE NOT NULL,
    paid_at TIMESTAMPTZ NULL,
    memo TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMPTZ NULL 
);
CREATE INDEX idx_bills_user_id ON bills(user_id);
CREATE INDEX idx_bills_due_date ON bills(due_date);
-- portion index（unpaid）
CREATE INDEX idx_bills_unpaid_due_date ON bills(due_date) 
    WHERE is_paid = FALSE AND deleted_at IS NULL;


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


CREATE TABLE companies(
    id INT,
    company_name  VARCHAR(255) NOT NULL,
    phone_num INT NOT NULL
)








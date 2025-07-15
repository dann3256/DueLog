-- name: InsertCompany :exec
INSERT INTO companies (
  bank_id,
  payment_deadline_id,
  company_name,
  phone_num,
  payment_amount,
  payment_limit
)
VALUES ($1, $2, $3, $4, $5, $6);

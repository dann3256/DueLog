-- name: InsertCompany :exec
INSERT INTO companies (
  id,
  bank_id,
  bill_id,
  payment_id,
  deadline_id,
  company_name,
  phone_num
)
VALUES ($1, $2, $3, $4, $5, $6, $7);

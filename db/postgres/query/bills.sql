-- name: InsertBill :exec
INSERT INTO bills (
  id,
  company_id,
  bank_id,
  amount,
  payment_limit,
  payment_date,
  description
)
VALUES ($1, $2, $3, $4, $5, $6, $7);

-- name: SelectBill :many
SELECT 
  companies.name,
  banks.name,
  amount,
  payment_limit,
  payment_date
FROM
  bills
INNER JOIN
  banks ON bills.bank_id = banks.id
INNER JOIN
  companies ON companies.company_id = companies.id
  


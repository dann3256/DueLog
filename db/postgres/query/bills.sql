-- name: InsertBill :exec
INSERT INTO bills (
  id,
  company_id,
  is_paid,
  description
)
VALUES ($1, $2, $3, $4);

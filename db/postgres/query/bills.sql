-- name: InsertBill :exec
INSERT INTO bills (
  user_id,
  company_id,
  is_paid,
  paid_at,
  memo
)
VALUES ($1, $2, $3, $4, $5);

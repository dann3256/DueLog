
-- name: InsertPayment :exec
INSERT INTO payment (
  id,
  amount,
  amount_limit
)
VALUES ($1, $2, $3);


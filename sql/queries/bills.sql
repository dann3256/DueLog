-- name: CreateBill :one
INSERT INTO bills (user_id, company_name, amount, due_date, is_paid, memo)
VALUES ($1, $2, $3, $4, $5, $6)
RETURNING *;

-- name: GetUnpaidBillsByUser :many
SELECT * FROM bills
WHERE user_id = $1
  AND is_paid = FALSE
  AND deleted_at IS NULL
ORDER BY due_date ASC;

-- name: GetBillByID :one
SELECT * FROM bills
WHERE id = $1 AND deleted_at IS NULL;

-- name: UpdateBill :exec
UPDATE bills
SET company_name = $2,
    amount = $3,
    due_date = $4,
    is_paid = $5,
    memo = $6,
    updated_at = CURRENT_TIMESTAMP
WHERE id = $1 AND deleted_at IS NULL;

-- name: SoftDeleteBill :exec
UPDATE bills
SET deleted_at = CURRENT_TIMESTAMP
WHERE id = $1 AND deleted_at IS NULL;

-- name: MarkBillAsPaid :exec
UPDATE bills
SET is_paid = TRUE
WHERE id = $1 AND deleted_at IS NULL;

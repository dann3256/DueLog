-- name: InsertDeadline :exec
INSERT INTO deadlines (id, payment_date)
VALUES ($1, $2);

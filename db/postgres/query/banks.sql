-- name: InsertBank :exec
INSERT INTO banks (name)
VALUES ($1);

-- name: SelectBank :one
SELECT name FROM banks
WHERE id = $1;

-- name: UpdateBank :exec
UPDATE banks
SET name = $1
WHERE id = $2;

-- name: DelteBank :exec
DELETE FROM banks
WHERE id = $1;
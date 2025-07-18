-- name: InsertUser :exec
INSERT INTO users (
  name,
  email
)
VALUES ($1, $2);

-- name: SelectUser :many
SELECT * FROM users
WHERE id = $1 AND deleted_at IS NULL;

-- name: UpdateUser :exec
UPDATE users
SET name = $1, email = $2
WHERE id = $3 AND deleted_at IS NULL;

-- name: DeleteUser :exec
UPDATE users
SET deleted_at = NOW()
WHERE id = $1 AND deleted_at IS NULL;
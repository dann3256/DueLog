
-- name: InsertUser :exec
INSERT INTO users (
  id,
  username,
  email
)
VALUES ($1, $2, $3);


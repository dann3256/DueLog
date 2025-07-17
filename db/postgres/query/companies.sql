-- name: InsertCompany :exec
INSERT INTO companies (
  id,
  name,
)
VALUES ($1, $2);

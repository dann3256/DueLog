-- name: InsertCompany :exec
INSERT INTO companies (name)
VALUES ($1);

-- name: SelectCompany :one
SELECT name FROM companies
WHERE id = $1;

-- name: UpdateCompany :exec
UPDATE companies
SET name = $1
WHERE id = $2;

-- name: DeleteCompany :exec
DELETE FROM companies
WHERE id = $1;
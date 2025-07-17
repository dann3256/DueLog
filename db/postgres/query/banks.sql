-- name: InsertBank :exec
INSERT INTO banks (
    id, 
    bank_name
)
VALUES ($1, $2);

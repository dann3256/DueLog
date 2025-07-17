-- name: InsertBank :exec
INSERT INTO banks (
    id, 
    name
)
VALUES ($1, $2);

# Extract SQL Formatter configurations from a Visual Studio Code workspace JSON.
.settings | with_entries(
  select(.key | startswith("SQL-")) | {
    # SQL Formatter VSCode extension uses "dialect"
    # while sql-formatter uses "language".
    key: (.key[21:] | if . == "dialect" then "language" else . end),
    value: (.value)
  }
) | .tabWidth |= 2

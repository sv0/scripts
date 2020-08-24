#!/bin/sh
echo  "Content-type: text/html";
echo 

host=$(echo "$QUERY_STRING" | grep -oP '(?<=host\=)([0-9a-z\.]{5,32})')
port=$(echo "$QUERY_STRING" | grep -oP '(?<=port\=)([0-9]{2,5})')
[ -z "$port" ] && port=22

cat << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SSH public keys from server $host</title>
</head>
<body>
<p>SSH public keys from server $host</p>
EOF

echo ssh-keyscan -p "$port" "$host"
echo "<table border=1>"
ssh-keyscan -p "$port" "$host" \
  | awk '{print "<tr><td>" $1 "</td><td>" $2  "</td><td>" $3 "</td></tr>" }'
echo "</table>"

cat << EOF
<form method="GET">
  <label for="host">Host:</label>
  <input id="host" type="text" name="host" value="$host">
  <label for="port">Port:</label>
  <input id="port" type="number" name="port" value="$port">
  <input type="submit" value="Submit">
</form>
</body>
</html>
EOF

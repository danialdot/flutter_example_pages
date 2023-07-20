#!/bin/sh

# Prompt the user for their email
read -p "Enter your email address: " email

# Extract the first part of the email until the '@' symbol
email_prefix=$(echo "$email" | cut -d'@' -f1)

# Function to echo ASCII art
echo_ascii_art() {
  echo "
  $1
  "
}

# Get User request for `danial` user
echo_ascii_art "Get User request"
response_get_user=$(curl --insecure \
  --request GET \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkYW5pYWwiLCJpYXQiOjE2ODk4MDY1MTQsImV4cCI6MTY4OTgxMDExNH0.YlAySmwyQVJaY3h4R1dQYzVVT21yNmdNT1JfcVFuTXJueld1WUNkXzYzRQ' \
   'https://getprofileresponseresult.'"$email_prefix"'.workers.dev/api/v1/user')

echo "$response_get_user"

echo_ascii_art "Great job! Keep up the good work! 😎🚀"

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

# Step 1: Login request
echo_ascii_art "Step 1: Login request"
response_login=$(curl --insecure \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "username" : "danial",
    "password" : "password"
}' \
  'https://loginresponseresult.'"$email_prefix"'.workers.dev/api/v1/auth/login')

echo "$response_login"

echo_ascii_art "Great job! Keep up the good work! 😎🚀"

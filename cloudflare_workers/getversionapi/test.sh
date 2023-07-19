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

# Step 1: Get Version request for 1.0.1
echo_ascii_art "Step 1: Get Version request"
response_get_version_1_0_1=$(curl --insecure \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "version" : "1.0.1"
}' \
   'https://getversionapi.'"$email_prefix"'.workers.dev/api/v1/app-config/app-update/get-version')

echo "$response_get_version_1_0_1"

# Step 1: Get Version request for 1.0.2
echo_ascii_art "Step 1: Get Version request"
response_get_version_1_0_2=$(curl --insecure \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "version" : "1.0.2"
}' \
   'https://getversionapi.'"$email_prefix"'.workers.dev/api/v1/app-config/app-update/get-version')

echo "$response_get_version_1_0_2"

echo_ascii_art "Great job! Keep up the good work! 😎🚀"

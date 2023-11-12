#!/bin/bash

# Check if a URL is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <URL> , where URL is similar to https://b8ff57c554f6.ngrok.app"
    exit 1
fi

# Assign the URL to a variable and add basePath
api_url="${1}/api/user/login"

echo $api_url

# JSON data for the API request 
json_data_user_demo='{"user": "misty94@demo.mail","pass": "ball"}'

# Invoke the API using curl with POST method and passing the JSON data
curl_response=$(curl -s -X POST -H "Content-Type: application/json" -d "$json_data_user_demo" "$api_url")

# Check the curl response
if [ $? -eq 0 ]; then
    echo "API Response:"
    echo "$curl_response"

    # Extract the token from the JSON response using jq
    token=$(echo "$curl_response" | jq -r '.token')

    if [ -n "$token" ]; then
        echo "Token to use in GitHub secret:"
        echo $token
    else
        echo "Error: Failed to extract token from API response."
    fi
else
    echo "Request is incorrect. Make sure you provided the correct NGrok URL such as https://b8ff57c554f6.ngrok.app"    
fi
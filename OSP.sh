#!/bin/bash

# Check if the correct number of arguments is provided
# if [ "$#" -ne 2 ]; then
  # echo "Usage: $0 VAR1 VAR2"
  # exit 1
# fi

GITHUB_SECRET=$1
GITHUB_ID=$2
API_KEY=$3

# Function to create and fill .env file for the frontend
create_env_file_frontend() {
  echo "GITHUB_SECRET=$1" > .env
  echo "GITHUB_ID=$2" >> .env
  echo "SERVERURL=http://localhost:4000/api" >> .env
  echo "API_KEY=$3" >> .env
}

# Function to create and fill .env file for the backend
create_env_file_backend(){
  echo "PORT=4000" > .env
  echo "MONGODB_URI=mongodb://127.0.0.1:27017/OSP" >> .env
  echo "SECRET=randomValue" >> .env
}

# Clone Repository 1
git clone https://github.com/OpenSourcePal/OpenSourcePal.git
cd OpenSourcePal

# Fill environment variables and create .env file for Repository 1
create_env_file_frontend "$GITHUB_SECRET" "$GITHUB_ID" "$API_KEY"

# Run npm install for Repository 1
npm install

# Run npm run dev for Repository 1 in the background
npm run dev:chrome &

# Clone Repository 2
cd ..
git clone https://github.com/OpenSourcePal/OSP-backend.git
cd OSP-backend

# Fill environment variables and create .env file for Repository 2
create_env_file_backend

# Run npm install for Repository 2
npm install

# Run npm run dev for Repository 2 in the background
npm run dev &
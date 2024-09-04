#!/bin/bash

# Define variables
REPO_DIR="/path/to/your/repo"
DOCKER_COMPOSE_FILE="/path/to/your/docker-compose.yml"

# Navigate to the repository directory
cd $REPO_DIR

# Pull the latest changes from the repository
echo "Pulling latest changes from the repository..."
git pull origin main

# Rebuild and restart the Docker containers
echo "Rebuilding and restarting Docker containers..."
docker-compose -f $DOCKER_COMPOSE_FILE down
docker-compose -f $DOCKER_COMPOSE_FILE up --build -d

echo "Deployment completed successfully."

#!/bin/bash

# Define the list of service repos to clone
REPOS=(
  "git@github.com:brian-burrows/outpost-authorization.git"
  "git@github.com:brian-burrows/outpost-etl-core.git"
  "git@github.com:brian-burrows/outpost-weather-service.git"
  "git@github.com:brian-burrows/trail-condition-etl.git"
)

echo "Starting local environment setup..."

for REPO_URL in "${REPOS[@]}"; do
  REPO_NAME=$(basename $REPO_URL .git)
  TARGET_PATH="./$REPO_NAME" 

  if [ ! -d "$TARGET_PATH" ]; then
    echo "Cloning $REPO_NAME into $TARGET_PATH..."
    git clone $REPO_URL $TARGET_PATH
    if [ $? -eq 0 ]; then
      echo "Successfully cloned $REPO_NAME."
    else
      echo "ERROR: Failed to clone $REPO_NAME. Check your SSH keys."
      exit 1
    fi
  else
    echo "Service $REPO_NAME already exists in $TARGET_PATH. Skipping clone."
  fi
done

echo "----------------------------------------------------"
echo "Setup complete! All service repos are in the root directory."
echo "Next steps:"
echo "1. Ensure your docker-compose.yml context paths are updated."
echo "2. Start the services: docker compose up --build"
echo "----------------------------------------------------"
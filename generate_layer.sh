#!/bin/bash

# Set the directory where the Dockerfile and requirements.txt are located
DIRECTORY="$(pwd)"

# Change it as per your requirement
LAYER_NAME="gemini-layer"

# Build the Docker image
docker build --platform linux/arm64 -t lambda-layer "$DIRECTORY"

# Run the Docker container to create the layer
docker run --name lambda-layer-container --platform linux/arm64 -v "$DIRECTORY:/app" lambda-layer

# create layers directory, if not created.
mkdir -p layers

# Move the zip file in layers directory.
mv "$DIRECTORY/$LAYER_NAME.zip" "$DIRECTORY/layers/$LAYER_NAME.zip"

# Stop the conainer
docker stop lambda-layer-container

# Remove the running conainer
docker rm lambda-layer-container

# Cleanup: remove the Docker image
docker rmi --force lambda-layer
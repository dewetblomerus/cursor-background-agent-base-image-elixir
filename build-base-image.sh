#!/bin/bash
# Script to build and push the base Docker image for Elixir/Phoenix Cursor Development

# Configuration - Update these values for your registry
REGISTRY="ghcr.io/dewetblomerus"  # GitHub Container Registry (change yourusername)
IMAGE_NAME="cursor-elixir-dev-base"
TAG="latest"

# Full image name
FULL_IMAGE_NAME="${REGISTRY}/${IMAGE_NAME}:${TAG}"

# Check if Dockerfile.base exists in current directory
if [ ! -f "Dockerfile.base" ]; then
    echo "❌ Dockerfile.base not found in current directory."
    echo "Please run this script from the cursor_background_agent_setup directory:"
    echo "  cd cursor_background_agent_setup"
    echo "  ./build-base-image.sh"
    exit 1
fi

echo "Building base Docker image..."
echo "Image: ${FULL_IMAGE_NAME}"
echo ""

# Build the base image
docker build -f Dockerfile.base -t "${FULL_IMAGE_NAME}" .

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Base image built successfully!"
    echo ""
    echo "To push the image to your registry, run:"
    echo "  docker push ${FULL_IMAGE_NAME}"
    echo ""
    echo "After pushing, update .cursor/Dockerfile line 3 to use:"
    echo "  FROM ${FULL_IMAGE_NAME}"
    echo ""
    echo "Registry-specific instructions:"
    echo ""
    echo "For Docker Hub:"
    echo "  1. Set REGISTRY to 'docker.io/yourusername'"
    echo "  2. Login: docker login"
    echo "  3. Push: docker push ${FULL_IMAGE_NAME}"
    echo ""
    echo "For GitHub Container Registry (ghcr.io):"
    echo "  1. Set REGISTRY to 'ghcr.io/yourusername'"
    echo "  2. Login: echo \$GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin"
    echo "  3. Push: docker push ${FULL_IMAGE_NAME}"
    echo ""
    echo "For other registries, follow their authentication and push procedures."
else
    echo ""
    echo "❌ Failed to build base image"
    exit 1
fi

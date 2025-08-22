#!/bin/bash
# Easy setup script for GitHub Container Registry

echo "🚀 Setting up GitHub Container Registry for Elixir/Phoenix Cursor development base image"
echo ""

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "Install it with: brew install gh"
    exit 1
fi

# Check if user is logged in to GitHub
if ! gh auth status &> /dev/null; then
    echo "🔐 Please login to GitHub first:"
    echo "  gh auth login"
    exit 1
fi

echo "✅ GitHub CLI is ready"
echo ""

# Create a GitHub Personal Access Token for container registry
echo "📝 You need a GitHub Personal Access Token with 'write:packages' permission."
echo ""
echo "1. Go to: https://github.com/settings/tokens/new"
echo "2. Give it a name like 'Docker Registry Access'"
echo "3. Select these scopes:"
echo "   ✓ write:packages (to push images)"
echo "   ✓ read:packages (to pull images)"
echo "4. Copy the token and paste it below"
echo ""

read -s -p "Enter your GitHub Personal Access Token: " GITHUB_TOKEN
echo ""

if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ No token provided"
    exit 1
fi

# Get GitHub username
GITHUB_USER=$(gh api user --jq '.login')
echo "GitHub username: $GITHUB_USER"

# Update build script with correct username
sed -i.bak "s/ghcr.io\/yourusername/ghcr.io\/$GITHUB_USER/g" build-base-image.sh

# Login to GitHub Container Registry
echo "🔑 Logging into GitHub Container Registry..."
echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_USER" --password-stdin

if [ $? -eq 0 ]; then
    echo "✅ Successfully logged into GitHub Container Registry!"
    echo ""
    echo "🏗️  Now building and pushing the base image..."
    echo ""

    # Build and push the image
    ./build-base-image.sh

    if [ $? -eq 0 ]; then
        echo ""
        echo "🚀 Pushing to GitHub Container Registry..."
                        docker push ghcr.io/$GITHUB_USER/cursor-elixir-dev-base:latest

        if [ $? -eq 0 ]; then
            echo ""
            echo "🎉 SUCCESS! Your base image is now available at:"
            echo "   ghcr.io/$GITHUB_USER/cursor-elixir-dev-base:latest"
            echo ""
            echo "🔧 Your .cursor/Dockerfile is already configured to use this image."
            echo ""
            echo "💡 Next time you start a Cursor background agent, it will be much faster!"
        else
            echo "❌ Failed to push image to registry"
            exit 1
        fi
    else
        echo "❌ Failed to build base image"
        exit 1
    fi
else
    echo "❌ Failed to login to GitHub Container Registry"
    exit 1
fi

# Elixir/Phoenix Cursor Development Environment

A two-stage Docker setup to dramatically reduce Cursor background agent startup times for Elixir/Phoenix projects.

## Overview

1. **Base Image** (`Dockerfile.base`): Contains all heavy installations (system packages, Elixir, Phoenix, development tools)
2. **Development Image** (your project's `.cursor/Dockerfile`): Lightweight image that uses the base image with project-specific configuration

## Setup Instructions

### 1. Build and Push the Base Image

First, update the registry configuration in `build-base-image.sh`:

```bash
# Edit these variables in build-base-image.sh
REGISTRY="ghcr.io/yourusername"  # GitHub Container Registry
IMAGE_NAME="cursor-elixir-dev-base"
TAG="latest"
```

Then build and push the base image:

```bash
# From the cursor_background_agent_setup directory
cd cursor_background_agent_setup

# Build the base image
./build-base-image.sh

# Push to your registry (follow the instructions printed by the script)
docker push ghcr.io/yourusername/cursor-elixir-dev-base:latest
```

### 2. Update the Development Dockerfile

Update your project's `.cursor/Dockerfile` to use your pushed base image:

```dockerfile
FROM ghcr.io/yourusername/cursor-elixir-dev-base:latest

# Your project-specific environment variables
ENV MIX_ENV=dev
ENV PHX_SERVER=true
ENV PHX_HOST=localhost
ENV PORT=4000

# Add any other project-specific configuration here

WORKDIR /workspace
CMD ["/bin/bash"]
```

### 3. Registry Options

#### Docker Hub

```bash
REGISTRY="docker.io/yourusername"
docker login
docker push docker.io/yourusername/cursor-elixir-dev-base:latest
```

#### GitHub Container Registry

```bash
REGISTRY="ghcr.io/yourusername"
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
docker push ghcr.io/yourusername/cursor-elixir-dev-base:latest
```

#### Private Registry

Follow your registry's authentication and push procedures.

## Benefits

- **Faster Startup**: Cursor background agents will start much faster since all heavy installations are pre-built
- **Consistency**: All developers and CI/CD will use the same base environment
- **Reduced Bandwidth**: Only downloads the lightweight development layer during agent startup
- **Easy Updates**: Update the base image when you need to add new system dependencies

## Maintenance

When you need to add new system dependencies or update Elixir versions:

1. Update `Dockerfile.base`
2. Rebuild and push the base image using `./build-base-image.sh`
3. The development Dockerfile automatically uses the latest base image

## File Structure

- `Dockerfile.base` - Heavy base image with all system dependencies and Elixir/Phoenix tools
- `build-base-image.sh` - Script to build and push the base image
- `setup-github-registry.sh` - Easy setup script for GitHub Container Registry
- `ubuntu_setup.sh` - Ubuntu setup script for reference
- `README-docker-setup.md` - This documentation file

In your Elixir/Phoenix project:

- `.cursor/Dockerfile` - Lightweight development image that uses the base image

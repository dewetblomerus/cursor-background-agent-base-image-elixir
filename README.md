# Cursor Background Agent Setup

A Docker-based development environment for Cursor background agents with Elixir/Phoenix development tools. This dramatically reduces Cursor background agent startup times by providing a pre-built base image with all heavy installations.

## Automated Docker Image Building

The repository is configured with GitHub Actions to automatically build and publish the Docker image to GitHub Container Registry (`ghcr.io`) whenever code is pushed to the `main` branch.

### How it works:

1. **Trigger**: Every push to `main` branch automatically triggers the build
2. **Build**: GitHub Actions builds the Docker image using the `Dockerfile`
3. **Publish**: The image is published to `ghcr.io/dewetblomerus/cursor-elixir-dev-base:latest`
4. **Multi-platform**: Builds for both `linux/amd64` and `linux/arm64` architectures
5. **Caching**: Uses GitHub Actions cache to speed up subsequent builds

## Using the Image

Once the image is published, you can use it in your Cursor projects by creating a `.cursor/Dockerfile`:

```dockerfile
FROM ghcr.io/dewetblomerus/cursor-elixir-dev-base:latest

ENV MIX_ENV=dev
ENV PHX_SERVER=true
ENV PHX_HOST=localhost
ENV PORT=4000

WORKDIR /workspace
CMD ["/bin/bash"]
```

## What's Included

The base image contains:

- Latest Ubuntu LTS
- Elixir and Erlang/OTP
- Phoenix framework
- Node.js and npm (for Phoenix assets)
- Git and essential development tools
- System dependencies for common Elixir libraries

## Benefits

- **Fast startup**: Cursor background agents start quickly with pre-built dependencies
- **Automatic updates**: Image rebuilds automatically on every code change
- **Multi-platform**: Works on both Intel and ARM64 machines
- **Consistent environment**: Same base image across all development environments
- **Reduced bandwidth**: Only downloads lightweight project-specific layers during agent startup

## Repository Structure

- `Dockerfile` - The Docker image definition with Elixir/Phoenix tools
- `.github/workflows/build-and-publish.yml` - Automated build and publish workflow

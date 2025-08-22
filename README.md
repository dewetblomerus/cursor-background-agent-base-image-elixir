# Cursor Background Agent Setup

This project provides a Docker-based setup environment for Cursor background agents with Elixir/Phoenix development tools.

## Automated Docker Image Building

The repository is configured with GitHub Actions to automatically build and publish the Docker image to GitHub Container Registry (`ghcr.io`) whenever code is pushed to the `main` branch.

### How it works:

1. **Trigger**: Every push to `main` branch automatically triggers the build
2. **Build**: GitHub Actions builds the Docker image using `Dockerfile.base`
3. **Publish**: The image is published to `ghcr.io/dewetblomerus/cursor-elixir-dev-base:latest`
4. **Multi-platform**: Builds for both `linux/amd64` and `linux/arm64` architectures
5. **Caching**: Uses GitHub Actions cache to speed up subsequent builds

### Manual Building

You can still build and push manually using the provided scripts:

```bash
# Build locally
./build-base-image.sh

# Setup GitHub registry (one-time setup)
./setup-github-registry.sh
```

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

## Files

- `Dockerfile.base` - The main Docker image definition with Elixir/Phoenix tools
- `build-base-image.sh` - Manual build script
- `setup-github-registry.sh` - GitHub registry setup script
- `.github/workflows/build-and-publish.yml` - Automated build workflow
- `README-docker-setup.md` - Detailed Docker setup documentation

## Benefits

- **Fast startup**: Cursor background agents start quickly with pre-built dependencies
- **Automatic updates**: Image rebuilds automatically on every code change
- **Multi-platform**: Works on both Intel and ARM64 machines
- **Consistent environment**: Same base image across all development environments

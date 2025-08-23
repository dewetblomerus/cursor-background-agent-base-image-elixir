# Cursor Elixir Development Base Image

Pre-built Docker image for fast Cursor background agent startup with Elixir/Phoenix development environment.

## Quick Start

Create a `.cursor/Dockerfile` in your Elixir project:

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

- Elixir 1.18.4 with Erlang/OTP 28.0.2
- Phoenix framework generator
- Node.js and npm for asset compilation
- PostgreSQL client
- Common development tools (git, vim, htop, etc.)
- GitHub CLI

## Why Use This?

- ⚡ **Fast startup**: Skip lengthy dependency installations
- 🔄 **Auto-updated**: Rebuilds automatically on changes
- 🌍 **Multi-platform**: Works on Intel and ARM64 machines

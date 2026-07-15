FROM node:20-slim

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Basic niceties Claude Code / most repos expect
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

ENTRYPOINT ["claude"]

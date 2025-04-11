#!/bin/bash
# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Pull a tiny model (free-tier compatible)
ollama pull starcoder:1b  # Only ~300MB

# Start Ollama
ollama serve

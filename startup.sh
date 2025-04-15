#!/bin/bash
export OLLAMA_NO_GPU=1
export OLLAMA_MAX_LOADED_MODELS=1
curl -fsSL https://ollama.com/install.sh | sh
ollama pull tinyllama
ollama serve --max-memory 400M

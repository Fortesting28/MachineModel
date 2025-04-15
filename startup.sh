#!/bin/bash
# Set memory limits (critical for free tier)
export OLLAMA_MAX_MEMORY=400M
export OLLAMA_NO_GPU=1

# Start Ollama with logging
ollama serve > /var/log/ollama.log 2>&1 &

# Wait for initialization
sleep 15

# Pull a free-tier compatible model (tinyllama works better than starcoder)
if ! ollama pull tinyllama; then
  echo "[ERROR] Model pull failed" >> /var/log/ollama.log
  
  # Fallback to even smaller model if needed
  if ! ollama pull gemma:2b; then
    exit 1
  fi
fi

# Continuous health check
while true; do
  if curl -s http://localhost:11434/api/tags >/dev/null; then
    echo "[STATUS] Ollama ready at $(date)" >> /var/log/ollama.log
    
    # Optional: Test generation capability
    if curl -s http://localhost:11434/api/generate \
      -d '{"model":"tinyllama","prompt":"test","stream":false}' >> /var/log/ollama.log 2>&1; then
      echo "[STATUS] AI responding correctly" >> /var/log/ollama.log
    fi
    
    break
  else
    echo "[WARN] Ollama not responding, retrying..." >> /var/log/ollama.log
    sleep 5
  fi
done

# Keep container alive
tail -f /var/log/ollama.log

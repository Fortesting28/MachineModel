#!/bin/bash
ollama serve > /var/log/ollama.log 2>&1 &
sleep 15
if ! ollama pull starcoder:1b; then
  echo "Model pull failed" >> /var/log/ollama.log
  exit 1
fi
while true; do
  if curl -s http://localhost:11434/api/tags >/dev/null; then
    echo "Ollama is running" >> /var/log/ollama.log
    break
  else
    sleep 5
  fi
done
tail -f /var/log/ollama.log

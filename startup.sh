#!/bin/bash
ollama serve &
sleep 10
ollama pull starcoder:1b
tail -f /dev/null

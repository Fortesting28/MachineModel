FROM ubuntu:22.04

# Install only essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install Ollama with strict memory limits
ENV OLLAMA_MAX_MEMORY=400M
RUN curl -fsSL https://ollama.com/install.sh | sh

EXPOSE 11434
COPY startup.sh .
RUN chmod +x startup.sh

CMD ["./startup.sh"]

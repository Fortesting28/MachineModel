FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://ollama.com/install.sh | sh
RUN mkdir -p /var/log
EXPOSE 11434
COPY startup.sh .
RUN chmod +x startup.sh
CMD ["./startup.sh"]

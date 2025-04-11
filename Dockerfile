FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://ollama.com/install.sh | sh
ENV PATH="/root/.ollama/bin:${PATH}"
COPY startup.sh .
RUN chmod +x startup.sh
CMD ["./startup.sh"]

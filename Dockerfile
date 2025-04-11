FROM ubuntu:22.04
COPY startup.sh .
RUN chmod +x startup.sh
CMD ["./startup.sh"]

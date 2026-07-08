FROM debian:trixie-slim
RUN apt update && apt install -y ca-certificates curl
RUN install -m 0755 -d /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && chmod a+r /etc/apt/keyrings/docker.asc
COPY trixie-docker.sources /etc/apt/sources.list.d/docker.sources
RUN apt update
RUN apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
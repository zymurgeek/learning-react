# Create this container with "docker build -t learningreact ."
# Reference:  https://stackoverflow.com/questions/25899912/install-nvm-in-docker
FROM ubuntu:17.10

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install package dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    libssl-dev \
    nodejs \
    npm \
    python \
    rsync \
    software-properties-common \
    wget \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

VOLUME /opt/app

WORKDIR /opt/app

ENTRYPOINT ["/bin/bash"]
#CMD ["--init-file", "/home/dgreenbaum/.profile"]

# To start a shell from the command line, run the script dockerrun

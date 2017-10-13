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
    python \
    rsync \
    software-properties-common \
    wget \
  && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION v6.10.3

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

ENTRYPOINT ["/bin/bash"]
#CMD ["--init-file", "/home/dgreenbaum/.profile"]

# To start a shell from the command line:
# docker run -ti -eDISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v/home/dgreenbaum/repos:/home/dgreenbaum/repos learningreact

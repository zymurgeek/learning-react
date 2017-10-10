# Create this container with "docker build -t learningreact ."
FROM ubuntu:17.10

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    emacs \
    firefox \
    git \
    libssl-dev \
    sudo \
    xterm

# Enable running X11 in container
# See also http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/dgreenbaum && \
    echo "dgreenbaum:x:${uid}:${gid}:Dave Greenbaum,,,:/home/dgreenbaum:/bin/bash" >> /etc/passwd && \
    echo "dgreenbaum:x:${uid}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "dgreenbaum ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dgreenbaum && \
    chmod 0440 /etc/sudoers.d/dgreenbaum && \
    chown ${uid}:${gid} -R /home/dgreenbaum

USER dgreenbaum
ENV HOME /home/dgreenbaum

# Install nvm (Node Version Manager)
RUN cd /home/dgreenbaum && touch .profile && curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh -o install_nvm.sh && bash install_nvm.sh

# Install Node 
RUN cd /home/dgreenbaum && . ~/.profile && nvm install v6.10.3

# Install Spacemacs
RUN git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

ENTRYPOINT ["/bin/bash"]
CMD ["--init-file", "/home/dgreenbaum/.profile"]

# To start a shell from the command line:
# docker run -ti -eDISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v/home/dgreenbaum/repos:/home/dgreenbaum/repos learningreact

FROM ubuntu:18.04

WORKDIR /workspaces

# Default ENV
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//mirror:\/\/mirrors\.ubuntu\.com\/mirrors\.txt/' /etc/apt/sources.list

# Install docker
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
RUN apt-get update && apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        dbus \
        software-properties-common \
        gpg-agent \
        git \
        git-lfs \
        sudo \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && add-apt-repository "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update && apt-get install -y --no-install-recommends \
        docker-ce-cli 

RUN mkdir /src && apt-get update && apt-get install -y python3-pip && pip3 install -U virtualenv platformio && platformio upgrade && platformio update 
ENV DEBIAN_FRONTEND=dialog

CMD ["/bin/bash"]
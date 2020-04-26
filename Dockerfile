FROM ubuntu:18.04

VOLUME /share

# Default ENV
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN sed -i -e 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//mirror:\/\/mirrors\.ubuntu\.com\/mirrors\.txt/' /etc/apt/sources.list

# Install docker
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /src && python3 -m pip install -U pip && pip3 install setuptools && pip3 install -U platformio && platformio upgrade && platformio update 
COPY build.sh /build.sh
RUN chmod a+x /build.sh
WORKDIR /src
COPY src/ /src/patch/
ENTRYPOINT ["/build.sh"]
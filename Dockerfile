# syntax=docker/dockerfile:1

ARG CODE_VERSION=latest
ARG USERNAME=lab
ARG PASSWORD=lab

FROM ubuntu:${CODE_VERSION}
ARG USERNAME
ARG PASSWORD

LABEL version="1.0" \
    author="thekyria" \
    description="thekyria's ubuntu playground"

RUN apt -y update && \
    apt -y upgrade
RUN apt install --yes --no-install-recommends \
    procps dos2unix nano bsdmainutils rsync zip sudo \
    iproute2 iputils-ping tcpdump net-tools wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
    tzdata
RUN apt install --yes --no-install-recommends \
    build-essential gdb cmake clang
RUN apt install --yes --no-install-recommends \
    openssh-server
RUN apt -y autoclean && \
    apt -y autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /var/run/sshd
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
  ssh-keygen -A 
EXPOSE 22
ENTRYPOINT service ssh restart && /bin/bash

RUN useradd -m -d /home/${USERNAME} -s /bin/bash -G sudo ${USERNAME}
RUN echo "${USERNAME}:${PASSWORD}" | chpasswd

# Build with:
#  docker build -f Dockerfile -t thekyria/theubuntu:latest .
# Run with:
#  docker run -it --rm -P --name theubuntu1 --network="bridge" thekyria/theubuntu:latest

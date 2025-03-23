# Use an official Ubuntu image as a base
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    openjdk-11-jdk \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y sudo

RUN sudo apt-get install -y software-properties-common
RUN sudo add-apt-repository ppa:ondrej/php
RUN sudo apt update

RUN sudo apt install -y php5.6

RUN php --version

RUN update-alternatives --config php

RUN sudo apt update \
    && sudo apt install python3

# Install Molprobity
RUN wget http://github.com/rlabduke/MolProbity/archive/master.zip
RUN unzip master.zip
RUN chmod +x ./MolProbity-master/install_via_bootstrap.sh
RUN ./MolProbity-master/install_via_bootstrap.sh

RUN chmod +x ./MolProbity-master/setup.sh
RUN ./MolProbity-master/setup.sh

EXPOSE 8000

CMD ["php", "-S", "localhost:8000"]

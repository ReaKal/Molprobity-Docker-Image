# Use an official Ubuntu image as a base
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    openjdk-11-jdk \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get install -y software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt update \
    && apt upgrade \
    && apt install -y php5.6

RUN apt-get install php5.6-gd php5.6-mysql php5.6-imap php5.6-curl \
    && php5.6-intl php5.6-pspell php5.6-recode php5.6-sqlite3 php5.6-tidy \
    && php5.6-xmlrpc php5.6-xsl php5.6-zip php5.6-mbstring php5.6-soap \
    && php5.6-opcache libicu65 php5.6-common php5.6-json php5.6-readline \
    && php5.6-xml libapache2-mod-php5.6 php5.6-cli 

RUN php --version

RUN update-alternatives --config php

# Install Molprobity
RUN wget -O install_via_bootstrap.sh https://github.com/rlabduke/MolProbity/raw/master/install_via_bootstrap.sh \
    && chmod +x install_via_bootstrap.sh
    && ./install_via_bootstrap.sh 4 \
    && cd molprobity \
    && chmod +x setup.sh \
    && setup.sh

EXPOSE 8000

CMD ["php", "-S", "localhost:8000"]

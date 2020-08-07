FROM php:7.4-apache-buster
RUN apt update && apt install -y \
    libapache2-mod-security2 \
    git \
    nano \
    libicu-dev \
    locales \
    jq \
    && docker-php-ext-install pdo_mysql intl opcache \
    && docker-php-ext-enable pdo_mysql intl opcache \
    && sed -i -e 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=fr_FR.UTF-8 \
    && sed -i 's/%h/%a/g' /etc/apache2/apache2.conf \
    && a2enmod headers remoteip rewrite
COPY conf/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY conf/security.conf /etc/apache2/conf-available/security.conf
COPY conf/bin/discord.sh /usr/bin/discord.sh

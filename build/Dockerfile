ARG PHP_FPM_VERSION=7.4-fpm
FROM php:$PHP_FPM_VERSION
LABEL maintainer="rajshakya2000@gmail.com"

ARG PROJECT_PATH=/var/www
ARG INSTALL_NODEJS=false

ENV PROJECT_PATH=$PROJECT_PATH
ENV INSTALL_NODEJS=${INSTALL_NODEJS}

# Installing dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    libmcrypt-dev \
    jpegoptim optipng pngquant gifsicle \
    unzip \
    curl \
    openssl \
    gnupg2
    
# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Installing extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd  \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/
RUN docker-php-ext-install gd

# Installing composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN rm -rf /var/lib/apt/lists/ && curl -sL https://deb.nodesource.com/setup_14.x | bash -

#Installing nodejs
RUN if [ "${INSTALL_NODEJS}" = "true" ]; then apt-get install nodejs -y ; fi
#Install node modules if package.json is available
RUN if ["${INSTALL_NODEJS}" = "true"]  && [-f package.json]; then npm install ; fi

# Allow container to write on host
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Change current user to www
USER www

# Copy existing application directory permissions
COPY --chown=www:www . ${PROJECT_PATH}

# Changing Workdir
WORKDIR ${PROJECT_PATH}
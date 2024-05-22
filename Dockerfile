FROM php:8.3-apache

# Instalar las extensiones necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmariadb-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copiar la configuración de Apache
COPY ./config/apache2.conf /etc/apache2/apache2.conf
COPY ./config/envvars /etc/apache2/envvars

# Crear directorios necesarios y establecer permisos
RUN mkdir -p /etc/apache2/logs && chown -R www-data:www-data /var/www/html

# Configurar el directorio de trabajo
WORKDIR /var/www/html

# Añadir el código de la aplicación
COPY ./web /var/www/html

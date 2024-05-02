# Utilisez l'image officielle PHP
FROM php:7.4-cli

# Mise à jour et installation des dépendances nécessaires
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libpq-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql intl zip

# Installation de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installation de Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Création du répertoire de travail
WORKDIR /var/www/html

# Installation de Symfony
RUN composer create-project symfony/skeleton .

# Clonage de votre projet Symfony
RUN git clone https://github.com/AntoineCalmettes/back-app.git
RUN symfony server:start
# Expose le port 8001 (ou tout autre port utilisé par votre application Symfony)
EXPOSE 8001

# Commande par défaut pour lancer le serveur Symfony
CMD ["php", "bin/console", "server:run", "0.0.0.0:8001"]

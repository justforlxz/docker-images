FROM docker.io/nextcloud:27

RUN set -x \
    && apt-get update \
    # Dependencies
    && apt-get install -y libbz2-dev \
    # PHP Module bz2
    && docker-php-ext-install bz2 \
    # PHP Module imap
    && apt-get install -y libc-client-dev libkrb5-dev \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    # PHP Module gmp
    && apt-get install -y libgmp3-dev \
    && docker-php-ext-install gmp \
    # PHP Module smbclient
    && apt-get install -y smbclient libsmbclient-dev \
    && pecl install smbclient \
    && docker-php-ext-enable smbclient \
    # ffmpeg
    && apt-get install -y ffmpeg \
    # imagemagick SVG support
    && apt-get install -y libmagickcore-6.q16-6-extra \
    # LibreOffice
    && apt-get install -y libreoffice \
    && apt-get install -y sudo \
    # Clean apt cache
    && apt-get clean

# Docker data sync image wit inotify/iwatch

This image is used to sync files from ``/var/www/src`` to ``/var/www/html`` (single direction).

## Usage in docker-compose

    image: netshops/dev_data_sync
    environment:
        TERM: xterm
    volumes:
        - ./src:/var/www/src
        - /var/www/html

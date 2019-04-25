#!/bin/sh
# wait-for-datacontainer.sh

set -e

cmd="$@"

until [[ ! -f '/var/www/html/shopware.php' ]]; do
  >&2 echo "data_container not ready - sleeping"
  sleep 5
done

>&2 echo "data_container ready - executing sync"
exec $cmd
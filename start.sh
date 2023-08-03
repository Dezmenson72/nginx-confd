#!/bin/bash

set -eo pipefail

etcd=${ETCD:-192.168.31.125:2379}

echo "[nginx-confd] etcd=$etcd"

# Loop until confd has updated the nginx config
until confd -onetime -node $etcd; do
  echo "[nginx-confd] waiting for confd to refresh nginx.conf"
  sleep 5
done

# Run confd in the background to watch the upstream servers
confd -interval 10 -node $etcd &
echo "[nginx-confd] confd is listening for changes on etcd..."

# Start nginx
echo "[nginx-confd] starting nginx service..."
nginx -g "daemon off;"

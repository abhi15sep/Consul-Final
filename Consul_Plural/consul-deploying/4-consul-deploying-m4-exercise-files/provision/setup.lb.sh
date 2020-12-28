#!/usr/bin/env bash

cp /vagrant/provision/haproxy.cfg /home/vagrant/.

# Run haproxy in a docker container
# Mount the haproxy config file
docker run -d \
           --name haproxy \
           -p 80:80 \
           --restart unless-stopped \
           -v /home/vagrant/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
           haproxy:1.6.5-alpine

# Install config into KV store for lb
curl -X PUT -d '4096' http://localhost:8500/v1/kv/prod/portal/haproxy/maxconn
curl -X PUT -d '5s' http://localhost:8500/v1/kv/prod/portal/haproxy/timeout-connect
curl -X PUT -d '50s' http://localhost:8500/v1/kv/prod/portal/haproxy/timeout-server
curl -X PUT -d '50s' http://localhost:8500/v1/kv/prod/portal/haproxy/timeout-client
curl -X PUT -d 'enable' http://localhost:8500/v1/kv/prod/portal/haproxy/stats
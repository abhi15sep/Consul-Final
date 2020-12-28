#!/bin/bash
apt-get install -y curl unzip

mkdir -p /var/lib/consul
mkdir -p /usr/share/consul
mkdir -p /etc/consul/conf.d

curl -OL https://releases.hashicorp.com/consul/1.8.4/consul_1.8.4_linux_amd64.zip
unzip consul_1.8.4_linux_amd64.zip
mv consul /usr/local/bin/consul

curl -OL https://releases.hashicorp.com/consul/1.8.4/consul_1.8.4_web_ui.zip
unzip consul_1.8.4_web_ui.zip -d dist
mv dist /usr/share/consul/ui

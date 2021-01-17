#!/bin/bash

HEKETI_VERSION="${1:-10.2.0}"

sudo mkdir -p /etc \
&& sudo mkdir -p /tmp \
&& curl -SL https://github.com/heketi/heketi/releases/download/v${HEKETI_VERSION}/heketi-v${HEKETI_VERSION}.linux.arm.tar.gz -o /tmp/heketi-v${HEKETI_VERSION}.linux.tar.gz \
&& sudo tar xzvf /tmp/heketi-v${HEKETI_VERSION}.linux.tar.gz -C /etc \
&& rm -vf /tmp/heketi-v${HEKETI_VERSION}.$linux.tar.gz \
&& sudo mkdir -p /etc/heketi \
&& sudo mkdir -p /var/lib/heketi \
&& sudo mkdir -p /var/log/heketi \
&& sudo cp /etc/heketi/heketi /usr/bin/heketi_${HEKETI_VERSION} \
&& sudo cp /etc/heketi/heketi-cli /usr/bin/heketi-cli_${HEKETI_VERSION} \
&& sudo ln -vsnf /usr/bin/heketi_${HEKETI_VERSION} /usr/bin/heketi \
&& sudo ln -vsnf /usr/bin/heketi-cli_${HEKETI_VERSION} /usr/bin/heketi-cli \
&& sudo ssh-keygen -f /etc/heketi/heketi_key -t rsa -N '' \
&& sudo chown -R pi:pi /etc/heketi/heketi_key* /var/lib/heketi /var/log/heketi /etc/heketi\
&& cd

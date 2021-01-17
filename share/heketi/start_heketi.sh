#!/bin/bash

HEKETI_CLI_SERVER=http://localhost:9080
HEKETI_CLI_USER=admin
HEKETI_CLI_KEY="AdminPass"

sudo systemctl daemon-reload \
&& sudo systemctl stop heketi \
&& sudo systemctl start heketi \
&& sleep 15 \
&& /usr/bin/heketi-cli -s $HEKETI_CLI_SERVER --user $HEKETI_CLI_USER --secret $HEKETI_CLI_KEY topology load --json=/etc/heketi/topology.json \
&& cd

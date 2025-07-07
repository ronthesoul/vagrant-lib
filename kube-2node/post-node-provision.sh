#!/bin/bash
set -e

API_IP="10.0.2.15"

while [ ! -f /vagrant/join.sh ]; do
  sleep 2
done


bash /vagrant/join.sh
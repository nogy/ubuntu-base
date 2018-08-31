#!/bin/bash -ex

apt-get autoremove -y --purge
apt-get clean
#rm -rf /var/lib/apt/lists/*

#!/bin/bash

mkdir -p /var/spool/slurmd
mkdir -p /var/spool/slurm/state
mkdir -p /var/log/slurm

chown -R slurm:slurm /var/spool/slurmd /var/spool/slurm /var/log/slurm

echo "Starting $1 on $(hostname -f)"

exec "$@"

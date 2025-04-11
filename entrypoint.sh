#!/bin/bash
set -e

if [[ "$1" == "slurmdbd" ]]; then
  echo "Fixing permissions for slurmdbd.conf..."
  chmod 600 /etc/slurm/slurmdbd.conf
  chown slurm:slurm /etc/slurm/slurmdbd.conf

  echo "Starting slurmdbd..."
  exec slurmdbd

elif [[ "$1" == "slurmctld" ]]; then
  echo "Preparing state directory for slurmctld..."
  mkdir -p /var/spool/slurm/state
  chown slurm:slurm /var/spool/slurm/state

  echo "Starting slurmctld..."
  exec slurmctld

elif [[ "$1" == "slurmd" ]]; then
  echo "Preparing spool directory for slurmd..."
  mkdir -p /var/spool/slurmd
  chown -R slurm:slurm /var/spool/slurmd

  echo "Starting slurmd..."
  exec slurmd

else
  echo "Unknown command: $1"
  exec "$@"
fi

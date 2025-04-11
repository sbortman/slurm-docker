#!/bin/bash
set -e

if [ "$SLURMDBD" = "yes" ]; then
  echo "Fixing permissions on slurmdbd.conf..."
  chmod 600 /etc/slurm/slurmdbd.conf
  echo "Starting slurmdbd..."
  exec slurmdbd -Dvvv

elif [ "$SLURMCTLD" = "yes" ]; then
  echo "Waiting for slurmdbd to be ready..."
  sleep 5
  echo "Starting slurmctld..."
  exec slurmctld -Dvvv

elif [ "$SLURMD" = "yes" ]; then
  echo "Starting slurmd..."
  exec slurmd -Dvvv

else
  exec "$@"
fi

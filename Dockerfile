FROM ubuntu:22.04

# Avoid interactive prompts (like tzdata)
ENV DEBIAN_FRONTEND=noninteractive

# Install Slurm, MariaDB client (compatible), and Munge
RUN apt-get update && \
    apt-get install -y slurm-wlm slurmdbd mysql-client munge && \
    id slurm || useradd -m slurm && \
    mkdir -p /var/spool/slurm/state /var/spool/slurmd /var/log /run/slurm && \
    chown -R slurm /var/spool/slurm /var/spool/slurmd /var/log /run/slurm

# Copy entrypoint logic
COPY entrypoint.sh /entrypoint.sh
RUN chown slurm:slurm /etc/slurm/slurmdbd.conf
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]

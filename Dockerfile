FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y slurm-wlm slurmdbd mysql-client munge && \
    id slurm || useradd -m slurm

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY slurmdbd.conf /etc/slurm/slurmdbd.conf
RUN chmod 600 /etc/slurm/slurmdbd.conf && \
    chown slurm:slurm /etc/slurm/slurmdbd.conf

ENTRYPOINT ["/entrypoint.sh"]

# Way to test ansible playbooks before running them on machine
FROM ubuntu:focal 

ARG TAG

WORKDIR /usr/local/bin

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y software-properties-common && apt-add-repository -y ppa:ansible/ansible && apt update && apt install -y curl git ansible build-essential && apt install -y vim

COPY . .

CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]

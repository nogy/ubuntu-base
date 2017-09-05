FROM ubuntu
MAINTAINER mwaeckerlin
ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
ENV LANG "en_US.UTF-8"
RUN apt-get update && apt-get install -y lsb-release language-pack-en less emacs-nox vim wget software-properties-common apt-transport-https nmap iputils-ping
RUN apt-add-repository https://dev.marc.waeckerlin.org/repository
RUN wget -O- https://dev.marc.waeckerlin.org/repository/PublicKey | apt-key add -
RUN apt-get update
RUN locale-gen ${LANG}
RUN update-locale LANG=${LANG}
RUN rm /root/.bashrc /etc/bash.bashrc /root/.profile /etc/profile /etc/skel/.bashrc

ENV PS1='\[\033[33;1;4m\]$(printf "%*s\n" "$((${COLUMNS:-$(tput cols)}))" "\D{%d.%m.%y %H.%M.%S}")\[\033[0m\]\n\[\033[36;1m\]\u\[\033[97m\]@docker[\[\033[36m\]\h\[\033[97m\]]:\[\033[37m\]\w\[\033[0m\]\$ '
ENV PS4='$(printf "\[\033[37;1m\]$0 \[\033[33m\]%4d\[\033[0m\]: " ${LINENO})'

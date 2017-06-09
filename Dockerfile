FROM ubuntu
MAINTAINER mwaeckerlin
ENV TERM xterm
ENV PS1='\[\033[1m\]$(printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " _)\[\033[0m\]\n\[\033[33;1m\]\D{%d.%m.%y %H.%M.%S} \[\033[36m\]\u\[\033[31m\]@\[\033[36m\]\h \[\033[37m\]\w\[\033[0m\]\n> '
ENV PS4='$(printf "\[\033[37;1m\]$0 \[\033[33m\]%4d\[\033[0m\]: " ${LINENO})'
ENV LANG "en_US.UTF-8"
RUN apt-get update
RUN apt-get install -y lsb-release language-pack-en less emacs-nox vim wget software-properties-common apt-transport-https
RUN apt-add-repository https://dev.marc.waeckerlin.org/repository
RUN wget -O- https://dev.marc.waeckerlin.org/repository/PublicKey | apt-key add -
RUN apt-get update
RUN locale-gen ${LANG}
RUN update-locale LANG=${LANG}
RUN rm /root/.bashrc /etc/bash.bashrc /root/.profile /etc/profile /etc/skel/.bashrc

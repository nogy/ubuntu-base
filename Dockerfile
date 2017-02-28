FROM ubuntu
MAINTAINER mwaeckerlin
ENV TERM xterm
ENV LANG "en_US.UTF-8"
RUN apt-get update
RUN apt-get install -y language-pack-en less emacs-nox

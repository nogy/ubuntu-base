FROM ubuntu
MAINTAINER mwaeckerlin
ENV TERM xterm
ENV LANG "en_US.UTF-8"
RUN apt-get update
RUN apt-get install -y lsb-release language-pack-en less emacs-nox wget software-properties-common apt-transport-https
RUN apt-add-repository https://dev.marc.waeckerlin.org/repository
RUN wget -O- https://dev.marc.waeckerlin.org/repository/PublicKey | apt-key add -
RUN apt-get update
RUN locale-gen ${LANG}
RUN update-locale LANG=${LANG}
ENTRYPOINT ["/bin/bash", "-ec"]

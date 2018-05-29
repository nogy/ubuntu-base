FROM ubuntu
MAINTAINER mwaeckerlin
ARG wwwuser="nginx"

ENV WWWUSER="${wwwuser}"
ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
ENV LANG "en_US.UTF-8"
ENV OTHER_LANGS="de_CH.UTF-8 de_DE.UTF-8 de_AT.UTF-8 fr_CH.UTF-8 fr_FR.UTF-8 it_CH.UTF-8 it_IT.UTF-8 es_ES.UTF-8"
ENV _TMP_PACKAGES="lsb-release wget software-properties-common"
ENV _REMOVE_PACKAGES="systemd base-passwd e2fslibs e2fsprogs initscripts insserv libapparmor1 libsystemd0 bsdutils util-linux libudev1 makedev mount sysv-rc sysvinit-utils"
ENV _PACKAGES="language-pack-en apt-transport-https"

RUN groupadd -g 500 ssl-cert

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y $_PACKAGES $_TMP_PACKAGES  $(for l in ${OTHER_LANGS}; do echo language-pack-${l%%_*}; done)
RUN apt-add-repository https://dev.marc.waeckerlin.org/repository
RUN wget -O- https://dev.marc.waeckerlin.org/repository/PublicKey | apt-key add -
RUN apt-get update
RUN for lang in ${OTHER_LANGS} ${LANG}; do \
      locale-gen ${lang}; \
      update-locale LANG=${lang}; \
    done
    
ENV PS1='\[\033[33;1;4m\]$(printf "%*s\n" "$((${COLUMNS:-$(tput cols)}))" "\D{%d.%m.%y %H.%M.%S}")\[\033[0m\]\n\[\033[36;1m\]\u\[\033[97m\]@docker[\[\033[36m\]\h\[\033[97m\]]:\[\033[37m\]\w\[\033[0m\]\$ '
ENV PS4='$(printf "\[\033[37;1m\]$0 \[\033[33m\]%4d\[\033[0m\]: " ${LINENO})'

RUN apt-get -y autoremove --allow-remove-essential --purge $_TMP_PACKAGES $_REMOVE_PACKAGES
ADD cleanup.sh /cleanup.sh
RUN /cleanup.sh

# update when used in derieved images
ONBUILD RUN apt-get update && apt-get dist-upgrade -y

# derieved images must have a /start.sh command as entrypoint
ONBUILD ADD start.sh /start.sh
ONBUILD CMD ["/start.sh"]

# derieved images must have a health check script at /health.sh
ONBUILD ADD health.sh /health.sh
ONBUILD HEALTHCHECK --interval=120s --timeout=30s --start-period=600s --retries=3 CMD /health.sh

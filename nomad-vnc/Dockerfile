# syntax=docker/dockerfile:1
FROM ubuntu:22.04

ARG UserName
ARG Uid
ARG Gid
ARG VNCPort
ARG VNCNumber

ENV VNCNumber ${VNCNumber}
ENV VNCPort ${VNCPort}

ENV UserName ${UserName}
ENV Uid ${Uid}
ENV Gid ${Gid}

ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&&  apt-get install -y \
        software-properties-common \
        dbus-x11 \
        locales \
        openssl \
        ssh \
        mc \
        net-tools \
        sudo \
        tigervnc-standalone-server \
        expect \
        xfonts-100dpi \
        xfonts-75dpi \
        xfonts-scalable \
        xfonts-cyrillic \
        fonts-ibm-plex \
        xterm \
        rxvt-unicode \
        fonts-ipafont-gothic \
        adwaita-icon-theme-full \
;   locale-gen en_US \
;   locale-gen en_US.UTF-8 \
;   locale-gen ru_RU \
;   locale-gen ru_RU.UTF-8 \
;   update-locale

RUN add-apt-repository -y ppa:mozillateam/ppa \
&&  apt-get update \
&&  apt-get install -y firefox-esr

# RUN apt-get install -y --no-install-recommends \
#         cinnamon-desktop-environment

RUN apt-get install -y --no-install-recommends \
        xfce4 \
        xfce4-goodies

ADD start.sh /

ENV HOME_SKEL /io.skel
ENV HOME /io

RUN groupadd -g ${Gid} ${UserName} || true \
;   useradd -u ${Uid} -g ${Gid} -G video -d ${HOME} -m -s /bin/bash ${UserName} \
;   echo "${UserName} ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UserName} \
;   install -m 700 -o ${UserName} -g ${UserName} -d /run/user/${UserName}

ADD skel ${HOME_SKEL}

# expose does not take any effect with network_mode=host
# EXPOSE ${VNCPort}/tcp

VOLUME [ "${HOME}" ]

USER ${UserName}
WORKDIR ${HOME}

ENV USER ${UserName}
ENV XDG_RUNTIME_DIR /run/user/${UserName}
ENV XAUTHORITY=/tmp/.docker.xauth
ENV DISPLAY=":${VNCNumber}"

CMD [ "/start.sh" ]

FROM ubuntu:22.04

ARG UserName=hermit
ARG Uid=1001
ARG Gid=1001
ARG VNCPassword="access"
ARG VNCNumber=7
ARG VNCPort=590${VNCNumber}
ARG VNCPortHttp=600${VNCNumber}

ENV VNCNumber=${VNCNumber}
ENV VNCPort=${VNCPort}
ENV VNCPortHttp=${VNCPortHttp}

ENV UserName ${UserName}
ENV Uid ${Uid}
ENV Gid ${Gid}

ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&&  apt-get install -y \
        software-properties-common \
        dbus-x11 \
        freerdp2-x11 \
        locales \
        mc \
        net-tools \
        sudo \
        tigervnc-standalone-server \
        tigervnc-xorg-extension \
        expect \
        xfonts-100dpi \
        xfonts-75dpi \
        xfonts-scalable \
        xfonts-cyrillic \
        xterm \
        rxvt-unicode \
        fonts-ipafont-gothic \
        adwaita-icon-theme-full \
&&  add-apt-repository -y ppa:mozillateam/ppa \
&&  apt-get update \
&&  apt-get install -y firefox-esr

RUN locale-gen en_US \
;   locale-gen en_US.UTF-8 \
;   locale-gen ru_RU \
;   locale-gen ru_RU.UTF-8 \
;   update-locale

RUN add-apt-repository -y ppa:niko2040/e19 \
&&  apt-get install -y enlightenment

# RUN apt-get install -y \
#         icewm

# RUN add-apt-repository -y ppa:profzoom/wmaker \
# &&  apt-get install -y \
#         wmaker

# RUN apt-get install -y \
#         blackbox \
#         fluxbox \
#         tint2

#RUN apt-get install -y \
#        olvwm \
#        wicd \
#        obmenu \
#        bmpanel

# RUN apt-get install -y \
#         openbox \
#         suckless-tools \
#         terminator \
#         lxpanel \
#         thunar \
#         geany

ADD vnc.sh /

ENV HOME_SKEL /io.skel
ENV HOME /io

RUN groupadd -g ${Gid} ${UserName} || true \
;   useradd -u ${Uid} -g ${Gid} -G video -d ${HOME} -m -s /bin/bash ${UserName} \
&&  echo "${UserName} ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UserName} \
&&  echo "${UserName} ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers \
&&  install -m 700 -o ${UserName} -g ${UserName} -d /run/user/${UserName}

RUN \
    mkdir -p ${HOME_SKEL}/.config \
;   mkdir -p ${HOME_SKEL}/.vnc \
;   expect -c "set timeout 3; \
    spawn /usr/bin/vncpasswd ${HOME_SKEL}/.vnc/passwd; \
    expect \"*?assword:*\"; send -- \"${VNCPassword}\r\"; \
    expect \"*?erify:*\"; send -- \"${VNCPassword}\r\"; \
    expect \"*?view-only password*\"; send -- \"n\r\"; send -- \"\r\"; \
    expect eof;" \
;   chmod -R a+r ${HOME_SKEL}

# expect -c "set timeout 3; \
#     spawn /usr/bin/vncpasswd ${HOME}/.vnc/passwd; \
#     expect \"*?assword:*\"; send -- \"${VNCPassword}\r\"; \
#     expect \"*?erify:*\"; send -- \"${VNCPassword}\r\"; \
#     expect \"*?view-only password*\"; send -- \"n\r\"; send -- \"\r\"; \
#     expect eof;"

EXPOSE ${VNCPort}/tcp
EXPOSE ${VNCPortHttp}/tcp

VOLUME [ "${HOME}" ]

USER ${UserName}
WORKDIR ${HOME}

ENV USER ${UserName}
ENV XDG_RUNTIME_DIR /run/user/${UserName}
ENV XAUTHORITY=/tmp/.docker.xauth
ENV DISPLAY=":${VNCNumber}"

# CMD [ "/usr/bin/vncserver", "-name", "nomad", "-depth", "32", "-geometry", "1600x1024", "-alwaysshared", ":0" ]
CMD [ "/bin/bash", "-c", "set -ex; chmod 0600 ${HOME}/.vnc/passwd || cp -vruT ${HOME_SKEL} ${HOME}; /vnc.sh" ]

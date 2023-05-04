#! /bin/bash
set -xe
cp -Truv ${HOME_SKEL} ${HOME}
if [ -e ${HOME}/.env ]; then
  . ${HOME}/.env
  export $(sed -e '/^#.*/d' -e 's/=.*//' ${HOME}/.env)
fi

: ${VNCPort:=$[5900 + ${VNCNumber}]}
: ${VNCGeometry:=1920x1080}
: ${VNCDepth:=24}
: ${VNCAddr:=127.0.0.1}
: ${VNCDir:=${HOME}/.vnc}
: ${VNCAuth:=${VNCDir}/passwd}
: ${VNC509Key:=${VNCDir}/vnckey-private.pem}
: ${VNC509Cert:=${VNCDir}/vnckey.pem}
: ${DISPLAY:=":${VNCNumber}"}

export XDG_RUNTIME_DIR=/run/user/${USER}
export XAUTHORITY=/tmp/.docker.xauth
export DISPLAY=":${VNCNumber}"

touch $XAUTHORITY
rm -rf /tmp/.X11-unix/* || true
mkdir -p /tmp/.X11-unix/

mkdir -p ${HOME}/.config
mkdir -p ${VNCDir}

test -e ${VNCAuth} \
||  expect -c "set timeout 3; \
      spawn /usr/bin/vncpasswd ${VNCAuth}; \
      expect \"*?assword:*\"; send -- \"${VNCPassword}\r\"; \
      expect \"*?erify:*\"; send -- \"${VNCPassword}\r\"; \
      expect \"*?view-only password*\"; send -- \"n\r\"; send -- \"\r\"; \
      expect eof;"
chmod -R u+rw ${VNCAuth}

test -e ${VNC509Key} -a -e ${VNC509Cert} \
|| /usr/bin/openssl req -x509 -newkey rsa -days 365 -nodes -config /usr/lib/ssl/openssl.cnf \
    -keyout ${VNC509Key} -out ${VNC509Cert} \
    -subj "/CN=${VNCAddr}" -addext "subjectAltName=IP:${VNCAddr}"

/usr/bin/vncserver $DISPLAY -geometry ${VNCGeometry} -depth ${VNCDepth} \
    -rfbauth ${VNCAuth} \
    -X509Key ${VNC509Key} -X509Cert ${VNC509Cert} \
    -rfbport ${VNCPort} -localhost no 

xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTHORITY nmerge -
tail -F ${VNCDir}/*.log

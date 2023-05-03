## prerequisites:
* Linux or WSL instance
* Docker (with docker compose; use docker-install.sh if need to install docker)
* make (just for convenience)

## usage:
* make build -- create the image (nomad-vnc)
* make sh -- start the container with an interactive shell
* make run -- start the container with a TigerVNC instance
* make xsh -- join an already running  container and run an interactive shell
* make clean -- clean up after work (remove extra docker objects)

## home storage
./io -- a directory with a dockerized home

## environment variables (use ./io/.env)
* VNCNumber -- the screen identifier [0..9]
* VNCPort -- RFB Port [5900..5909]
* VNCGeometry -- Screen dimensions (default: 1920x1080}
* VNCDepth -- Color Depth (default: 24)
* VNCAddr -- the address of the host interface (mostly for X509 generation, default: 127.0.0.1)
* VNCDir  -- the base path for VNC files (default: ${HOME}/.vnc)
* VNCAuth -- the path to the VNC password file (default ${VNCDir}/passwd)
* VNC509Key -- the path to the SSL private key (default: ${VNCDir}/vnckey-private.pem)
* VNC509Cert -- the path to the SSL certificate (default: ${VNCDir}/vnkey.pem)

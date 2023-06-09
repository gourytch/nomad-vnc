## prerequisites:
* Linux or WSL instance
* Docker with docker compose; use docker-install.sh if need.
* make

## what must be done before create image
1. create `env.config` from the template `env.config.template`.
2. edit `env.config` and adjust it to your needs.

## usage:
* `make build` -- create the image (nomad-vnc)
* `make sh` -- start the container with an interactive shell
* `make run` -- start the container with a TigerVNC instance
* `make xsh` -- join an already running  container and run an interactive shell
* `make up` -- start the container with a TigerVNC instance as a background service
* `make down` -- the opposite to `make up` and the same as `make clean`
* `make clean` -- clean up after work (remove extra docker objects)

## home template
`./nomad-vnc/skel` -- a directory with a skeleton for a new home directory

## home storage
`./io` -- a directory with a dockerized home

## environment variables (use ./io/.env)
* `VNCNumber` -- the screen identifier [0..9]
* `VNCPort` -- RFB Port [5900..5909], (default: 5900 + $VNCNumber)
* `VNCGeometry` -- Screen dimensions (default: 1920x1080)
* `VNCDepth` -- Color Depth (default: 24)
* `VNCAddr` -- the address of the host interface (mostly for X509 generation, default: 127.0.0.1)
* `VNCDir`  -- the base path for VNC files (default: `${HOME}/.vnc`)
* `VNCAuth` -- the path to the VNC password file (default `${VNCDir}/passwd`)
* `VNC509Key` -- the path to the SSL private key (default: `${VNCDir}/vnckey-private.pem`)
* `VNC509Cert` -- the path to the SSL certificate (default: `${VNCDir}/vnkey.pem`)
* `XSession` -- the script or the application to start as a session/desktop/window manager

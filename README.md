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

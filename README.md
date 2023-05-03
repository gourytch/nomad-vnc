## prerequisites:
* Linux or WSL instance
* Docker (with docker compose; use docker-install.sh if need to install docker)
* make (just for convenience)

## usage:
* make build -- create image (nomad-vnc)
* make sh -- start container with interactive bash
* make run -- start container with TigerVNC
* make xsh -- execute bash in running container
* make clean -- clean up after work (remove extra docker objects)

## home storage
./io -- a directory with dockerized home

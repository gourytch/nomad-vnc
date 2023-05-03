.PHONY: build run sh xsh clean

PROJECT = nomad
IMAGE = nomad-vnc
IO = $(abspath io)
UserName := $(shell id -un)
Uid := $(shell id -u)
Gid := $(shell id -g)
VNCNumber := 7

COMPOSER = UserName=$(UserName) Uid=$(Uid) Gid=$(Gid) VNCNumber=${VNCNumber} IO=${IO} docker compose -p $(PROJECT)

build:
	$(COMPOSER) build $(IMAGE)

run: ${IO}
	$(COMPOSER) run $(IMAGE)

sh: ${IO}
	$(COMPOSER) run $(IMAGE) /bin/bash --login

xsh: ${IO}
	$(COMPOSER) exec $(IMAGE) /bin/bash --login

${IO}:
	mkdir -p ${IO}

clean:
	$(COMPOSER) down --remove-orphans

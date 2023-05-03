.PHONY: build run sh xsh clean

PROJECT = nomad
IMAGE = nomad-vnc

IO = $(abspath io)

COMPOSER = IO=${IO} docker compose -p $(PROJECT)
SHELL = /bin/bash

include ./env.config
export $(shell sed 's/=.*//' ./env.config)

VNCPort = $(shell expr 5900 + $(VNCNumber) )

build: .env nomad-vnc/skel/.env
	$(COMPOSER) build $(IMAGE)

run: ${IO}
	$(COMPOSER) run $(IMAGE)

sh: ${IO}
	$(COMPOSER) run $(IMAGE) /bin/bash --login

xsh:
	$(COMPOSER) exec $(IMAGE) /bin/bash --login

${IO}:
	mkdir -p ${IO}

nomad-vnc/skel/.env: .env
	mkdir -p $(shell dirname $@)
	cp -u $^ $@

.env: ./env.config
	@echo "create .env for screen number <$(VNCNumber)>, port <$(VNCPort)>"
	@echo "# Evironment file for the $(PROJECT) instance" >$@
	@echo "# as-is part #" >>$@
	@cat $< >>$@
	@echo "# generated part #" >>$@
	@echo "VNCPort=$(VNCPort)" >>$@
	@echo "UserName=$(shell id -un)" >>$@
	@echo "Uid=$(shell id -u)" >>$@
	@echo "Gid=$(shell id -g)" >>$@
	@echo "# EOF #" >>$@

clean:
	$(COMPOSER) down --remove-orphans

REPO = cabanaonline/seqmonk
NAME = seqmonk
TAG = 1.0

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) \
		./

run-seqmonk:
	xhost +localhost && docker run -i --rm --net=host -e DISPLAY --name seqmonk cabanaonline/seqmonk:1.0

-include docker-helper-scripts/Makefile
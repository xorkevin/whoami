.PHONY: all dev

IMAGE=xorkevin/whoami
VERSION=1
TAG=$(IMAGE):$(VERSION)
LATEST=$(IMAGE):latest

all: build-docker

dev:
	go run server.go

.PHONY: build-docker publish-docker docker

build-docker:
	docker build -t $(LATEST) -t $(TAG) .

publish-docker:
	docker push $(TAG)
	docker push $(LATEST)

docker: build-docker publish-docker

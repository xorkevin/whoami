.PHONY: all dev build publish

IMAGE=xorkevin/whoami
VERSION=1
TAG=$(IMAGE):$(VERSION)
LATEST=$(IMAGE):latest

all: build

dev:
	go run server.go

build:
	docker build -t $(LATEST) -t $(TAG) .

publish:
	docker push $(TAG)
	docker push $(LATEST)

.PHONY: all build publish

IMAGE=xorkevin/whoami
VERSION=1
TAG=$(IMAGE):$(VERSION)
LATEST=$(IMAGE):latest

BIN_DIR=bin
BIN_PATH=bin/whoami
MAIN_PATH=server.go

all: build

dev:
	go run server.go

build:
	mkdir -p $(BIN_DIR)
	if [ -f $(BIN_PATH) ]; then rm $(BIN_PATH); fi
	CGO_ENABLED=0 go build -trimpath -ldflags "-w -s" -o $(BIN_PATH) $(MAIN_PATH)
	docker build -t $(LATEST) -t $(TAG) .

publish:
	docker push $(TAG)
	docker push $(LATEST)

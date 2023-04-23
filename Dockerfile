FROM golang:1.20.3-alpine3.17 as builder
WORKDIR /usr/local/src/go/whoami
RUN adduser -u 10001 -D whoami
COPY go.mod ./
RUN go mod download && go mod verify
COPY . ./
RUN go build -v -trimpath -ldflags "-w -s" -o /usr/local/bin/whoami .

FROM scratch
MAINTAINER xorkevin <kevin@xorkevin.com>
WORKDIR /home/whoami
COPY --from=builder /etc/passwd /etc/
COPY --from=builder /usr/local/bin/whoami /usr/local/bin/
EXPOSE 8080
USER whoami
ENTRYPOINT ["/usr/local/bin/whoami"]

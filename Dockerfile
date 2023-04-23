FROM cgr.dev/chainguard/go:1.20.3 as builder
WORKDIR /usr/local/src/go/whoami
COPY go.mod ./
RUN go mod download && go mod verify
COPY . ./
RUN CGO_ENABLED=0 go build -v -trimpath -ldflags "-w -s" -o /usr/local/bin/whoami .

FROM cgr.dev/chainguard/static:latest
MAINTAINER xorkevin <kevin@xorkevin.com>
WORKDIR /home/whoami
COPY --from=builder /usr/local/bin/whoami /usr/local/bin/
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/whoami"]

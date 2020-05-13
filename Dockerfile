FROM scratch
MAINTAINER xorkevin <kevin@xorkevin.com>
WORKDIR /home/whoami
COPY bin/whoami .
EXPOSE 8080
ENTRYPOINT ["/home/whoami/whoami"]

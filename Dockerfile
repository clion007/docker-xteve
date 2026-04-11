# syntax=docker/dockerfile:1

# Build the final combined image
FROM clion007/alpine

LABEL mantainer="Clion Nihe Email: clion007@126.com"

ARG BRANCH="edge"

ADD https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip /tmp/xteve.zip
  
# add local files
COPY root/ /

RUN set -ex; \
    chmod +x /init; \
    # unzip xteve to bin path
    unzip /tmp/xteve.zip -d /usr/bin/; \
    chmod +x /usr/bin/xteve; \
    \
    # install pakeges needed
    apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/$BRANCH/main \
    --repository=http://dl-cdn.alpinelinux.org/alpine/$BRANCH/community \
    shadow \
    su-exec \
    ; \
    \
  # set xteve process user and group
  groupadd -g 1000 xteve; \
  useradd -u 1000 -s /bin/nologin -M -g 1000 xteve; \
  chown xteve:xteve /usr/bin/xteve; \
  \
  rm -rf \
      /var/cache/apk/* \
      /var/tmp/* \
      /tmp/* \
  ;

# Expose 80 Port need set individual IP to container,34400 port is default
EXPOSE 80 34400

# entrypoint /init set in clion007/alpine base image

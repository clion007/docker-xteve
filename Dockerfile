# syntax=docker/dockerfile:1

# Build the final combined image
FROM clion007/alpine

LABEL mantainer="Clion Nihe Email: clion007@126.com"

ARG BRANCH="edge"

WORKDIR /tmp/xteve

ADD https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip ../xteve.zip
  
# add local files
COPY --chmod=+x root/ /

RUN set -ex; \
    # unzip xteve to bin path
    unzip ../xteve.zip -d /usr/bin/; \
    chmod +x /usr/bin/xteve; \
    \
    # install pakeges needed
    apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/$BRANCH/main \
    --repository=http://dl-cdn.alpinelinux.org/alpine/$BRANCH/community \
    su-exec \
    ; \
    \
    # virtual install temporary pakges needed
    apk add --no-cache --virtual .user-deps \
    shadow \
  ; \
  \
  # set xteve process user and group
  groupadd -g 101 xteve; \
  useradd -u 100 -s /bin/nologin -M -g 101 xteve; \
  chown xteve:xteve /usr/bin/xteve; \
  \
  # make dir for config and data
  mkdir -p /config; \
  chown xteve:xteve /config; \
  \
  apk del --no-network .user-deps; \
  rm -rf \
      /var/cache/apk/* \
      /var/tmp/* \
      /tmp/* \
  ;

# Expose 80 Port need set individual IP to container
EXPOSE 80

# entrypoint set in clion007/alpine base image
CMD ["-p=80"]
    

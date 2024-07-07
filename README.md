# Xteve Docker Project

## What is Xteve?
M3U Proxy for Plex DVR and Emby Live TV, it is also could be useed for jellyfin, kodi, potplayer and other software on pc support m3u stream player or Apps on mobiole and smart TV. This docker project is based on [xteve-project](https://github.com/xteve-project/xTeVe) without ffmpeg and vlc player, with only 8M size from my base alpine linux image.

## Features
* Has only 8M smallest image size compared to others;
* You will get fastest deploy experience, especially for chinese, with respository both on aliyun and dockerhub;
* No support any buffer on xteve, then you will get faster play speed on change channel(I think that is player's and mediaserver's work for decode medias);
* Support 80 port by default, so you can use without port in m3u and xmltv url for your jellyfin, player or apps;
* For runs on 80 port, you need set a dedicated ip address for your container(macvlan or ipvlan);
* Container xteve programe runs not by root user, more security;
* You can set your port and config path in config file like sample config file;
* Support config file localization, you don't need setting it everytime on run;
* Default local time zone is Asia/Shanghai;
* Automaticly check and update when there is updated on offical site.

## Usage
To help you get started creating a container from this image you can use the docker cli.

### Docker cli
```
docker run -d \
  --name=Xteve \
  --net='vnet' \
  --ip='10.*.*.*' \
  -e 'UMASK'='022' \
  -e PUID=1000 \
  -e PGID=1000 \
  -p 34400:34400 `#optional` \
  -v /path/to/config:/config \
  --restart unless-stopped \
  registry.cn-chengdu.aliyuncs.com/clion/xteve
```

Get more help in settings, you can read the documents of [Xteve Offical](https://github.com/xteve-project/xTeVe-Documentation/blob/master/en/configuration.md)

## Parameters
Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate <external>:<internal> respectively. For example, -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080 outside the container.

* ```--net='vnet'``` for network - Virtual network card on your host for docker.
* ```--ip='10.*.*.*'``` for IP address of container -Dedicated IP address in your local network.
* ```-p 34400``` Optional - Http webUI (you need to set up your own certificate), not need by default.
* ```-e PUID=99``` for UserID - see below for explanation.
* ```-e PUID=100``` for GroupID - see below for explanation.
* ```-e UMASK=022``` for UMASK - see below for explanation.
* ```-v /config``` Jellyfin data storage location. This can grow very large, 50gb+ is likely for a large collection.

## Umask for running applications
For all of my images I provide the ability to override the default umask settings for services started within the containers using the optional -e UMASK=022 setting. Keep in mind umask is not chmod it subtracts from permissions based on it's value it does not add.

## User / Group Identifiers
When using volumes (-v flags), permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user PUID and group PGID.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

## Thanks
[xteve-project](https://github.com/xteve-project/xTeVe)

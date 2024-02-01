## zerotier-realm
A docker container that integrates ZeroTier and Realm to achieve service isolation and simpler forwarding between the different containers. 


## zerotier-realm docker
```
version: '3'
services:
  realm-zerotier: 
    image: crestfallmax/zerotier-realm:v0.1
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/net/tun
    volumes:
      - ./zerotier-one:/var/lib/zerotier-one
      - ./realm.toml:/realm.toml
    command:
      - xxxxxxxxxx
```
If you want to isolate the container and host, you shouldn't add `network_mode: host`.

## other service docker
```
version: '3'
services:
  service-one:
    image: service-one:latest
    restart: always
    ports:
      - 12345:12345
    networks:
      - default
      - realm-zerotier_default

networks:
  realm-zerotier_default:
    external: true
```

Then configure realm.toml.
```
[network]
no_tcp = false
use_udp = true

[[endpoints]]
listen = "0.0.0.0:4000"
remote = "service-one:12345"
```

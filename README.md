# docker-riak
dockerfile to boot a single riak node

# Running a single instance and exposing the ports

```
docker run --publish=8087:8087 --publish=8098:8098 binarytemple/riak:latest
```

# Running a single instance and exposing it's volumes 

```
docker run -v etc-riak:/etc/riak -v var-lib-riak:/var/lib/riak --publish=8087:8087 --publish=8098:8098 binarytemple/riak:latest
```
# Inspecting the exported riak data volumes

```
docker@local:~$ docker volume ls | grep riak
local               etc-riak
local               var-lib-riak
```

```
docker@local:~$ docker volume inspect var-lib-riak
[
    {
        "Name": "var-lib-riak",
        "Driver": "local",
        "Mountpoint": "/mnt/sda1/var/lib/docker/volumes/var-lib-riak/_data",
        "Labels": null
    }
]
```

```
docker@local:~$ sudo su -
Boot2Docker version 1.11.0, build HEAD : 32ee7e9 - Wed Apr 13 20:06:49 UTC 2016
Docker version 1.11.0, build 4dc5990
root@local:~# ls -la /mnt/sda1/var/lib/docker/volumes/var-lib-riak/_data
total 36
drwxr-xr-x    8 102      105           4096 Apr 19 11:09 .
drwxr-xr-x    3 root     root          4096 Apr 19 11:09 ..
-r--------    1 102      105             20 Apr 19 00:00 .erlang.cookie
drwxr-xr-x   66 102      105           4096 Apr 19 11:09 anti_entropy
drwxr-xr-x   66 102      105           4096 Apr 19 11:09 bitcask
drwxr-xr-x    3 102      105           4096 Apr 19 11:09 cluster_meta
drwxr-xr-x    2 102      105           4096 Apr 19 11:09 generated.configs
drwxr-xr-x    2 102      105           4096 Apr 19 11:09 kv_vnode
drwxr-xr-x    2 102      105           4096 Apr 19 11:09 ring
```

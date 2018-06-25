#!/usr/bin/env sh

containerName=nginx_main
containerTag=latest
containerLabel="$containerName:$containerTag"

if [ "_$1" = "_clean" ]; then
    docker stop $containerName
    docker rm -v $containerName
    exit 0
fi
if [ "_$1" = "_cleani" ]; then
    docker stop $containerName
    docker rm -v $containerName
    docker rmi "$containerLabel"
    exit 0
fi

#docker build -t $containerLabel .

docker run  -itd \
    --volume=$pwd/html:/usr/share/nginx/html \
    --volume=$pwd/nginx.conf:/etc/nginx/nginx.conf \
    --volume=$pwd/conf.d/default.conf:/etc/nginx/conf.d/default.conf \
    --volume=$pwd/../lets/etc/letsencrypt:/letsencrypt:ro \
    -p 80:80 \
    -p 443:443 \
    --restart=always \
    --log-driver=journald \
    --name=$containerName \
    --workdir=/root/ \
    nginx:latest


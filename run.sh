#!/usr/bin/env bash

p1080=1920x1080
p720=1280x720
p169=1600x900

if [ $(uname -m) == 'x86_64' ] 
then
	tag=
elif [ $(uname -m) == 'aarch64' ] 
then 
	tag=:rpi
else
	echo 'not matched platform!'
	exit 0
fi

if [[ -f "~/rosuser_home" ]]
then
	mkdir -p "~/rosuser_home"
	chmod -Rf 777 "~/rosuser_home"
fi

NAME=build-snowboy

docker rm -f $NAME

docker system prune -f

docker run -it --rm --name $NAME \
	-v "$(pwd)/src:/src:rw" \
	-v "/dev:/dev" \
	--privileged \
	wn1980/build-snowboy${tag} bash

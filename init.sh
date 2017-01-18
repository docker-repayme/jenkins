#!/bin/sh

# get docker group id of host system
DOCKER_GROUPID=$(getent group docker | cut -d: -f3)

# give jenkins user permission for docker group
if [ "$DOCKER_GID" ]; then
    groupadd -g $DOCKER_GID hostdocker
    usermod -a -G hostdocker jenkins
fi

# start jenkins
exec "/usr/local/bin/jenkins.sh"
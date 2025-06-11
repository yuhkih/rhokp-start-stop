#!/bin/bash

REGISTRY_USER=<registry.redhat.ioのユーザー>
REGISTRY_PWD=<registry.redhat.ioのパスワード>
MY_KEY=<生成したアクセスキー> 

if [ $# -ne 1 ]
then
 echo "How to use: "
 echo " okp.sh start   : Start RHOKP with the latest image"
 echo " okp.sh stop    : Stop RHOKP"
 echo " okp.sh restart : Restart RHOKP with the latest image"
exit
fi

case "$1" in
  start)
    # Check if the image is latest, if not, pull the latest.
    echo "Checking the latest RHOKP image..."
    echo "Logging in to registry.redhat.io."
    podman login registry.redhat.io -u  $REGISTRY_USER -p $REGISTRY_PWD
    podman pull registry.redhat.io/offline-knowledge-portal/rhokp-rhel9:latest

    # start the document container
    echo "Start RHOKP server" 
    podman run --rm -p 8080:8080 -p 8443:8443 --env "ACCESS_KEY=$MY_KEY" -d registry.redhat.io/offline-knowledge-portal/rhokp-rhel9:latest
    podman ps | grep offline-knowledge-portal
    ;;

  stop)
    # stop RHOKP 
    RHODP_NAME=`podman ps | grep "registry.redhat.io/offline-knowledge-portal/rhokp-rhel9" |  awk '{print $NF}'`
    echo "Stopping RHOKP... it takes a while..."
    podman stop  $RHODP_NAME
    ;;

  restart)
    # stop RHOKP
    RHODP_NAME=`podman ps | grep "registry.redhat.io/offline-knowledge-portal/rhokp-rhel9" |  awk '{print $NF}'`
    echo "Stopping RHOKP... it takes a while..."
    podman stop  $RHODP_NAME

    # Check if the image is latest, if not, pull the latest.
    echo "Checking the latest RHOKP image..."
    echo "Logging in to registry.redhat.io."
    podman login registry.redhat.io -u  $REGISTRY_USER -p $REGISTRY_PWD
    podman pull registry.redhat.io/offline-knowledge-portal/rhokp-rhel9:latest

    # start the document container
    echo "Start RHOKP server" 
    podman run --rm -p 8080:8080 -p 8443:8443 --env "ACCESS_KEY=$MY_KEY" -d registry.redhat.io/offline-knowledge-portal/rhokp-rhel9:latest
    podman ps | grep offline-knowledge-portal
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
    ;;
esac



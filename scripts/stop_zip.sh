#!/bin/bash

export PROJECT_HOME="$( cd "$(dirname "$0")" ; cd .. ; pwd -P )"
source ${PROJECT_HOME}/scripts/config.sh

container_ids=`/usr/local/bin/docker ps -aqf "name=${SERVICE_ZIP}.*"`
for cid in ${container_ids}
do
 /usr/local/bin/docker stop ${cid}
done


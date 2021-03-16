#!/bin/bash

export PROJECT_HOME="$( cd "$(dirname "$0")" ; cd .. ; pwd -P )"
source ${PROJECT_HOME}/scripts/config.sh

if [[ ! -d "${LOG_DIR}" ]]; then
  mkdir -p ${LOG_DIR}
fi

${PROJECT_HOME}/scripts/stop_zip.sh

/usr/local/bin/docker container run -d --rm --name ${SERVICE_ZIP} -p 8801:8888 -v ${PROJECT_HOME}/.zipline:/root/.zipline -v ${PROJECT_HOME}/backstreet/use_zipline:/home/backstreet/use_zipline ${IMAGE_ZIP}:${VERSION}

container_ids=`/usr/local/bin/docker ps -aqf "name=${SERVICE_ZIP}.*"`
for cid in ${container_ids}
do
 /usr/local/bin/docker logs -f ${cid} > ${PROJECT_HOME}/logs/${SERVICE_ZIP}_${cid}.log 2>&1 &
done


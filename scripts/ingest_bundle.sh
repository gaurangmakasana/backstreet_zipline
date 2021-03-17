#!/bin/bash

export PROJECT_HOME="$( cd "$(dirname "$0")" ; cd .. ; pwd -P )"
source ${PROJECT_HOME}/scripts/config.sh

if [[ ! -d "${LOG_DIR}" ]]; then
  mkdir -p ${LOG_DIR}
fi

${PROJECT_HOME}/scripts/stop_zip.sh

/usr/local/bin/docker container run -it --rm --name ${SERVICE_ZIP} -v ${PROJECT_HOME}/.zipline:/root/.zipline -v ${PROJECT_HOME}/backstreet/use_zipline:/home/backstreet/use_zipline ${IMAGE_ZIP}:${VERSION} /bin/bash


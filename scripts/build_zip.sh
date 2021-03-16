#!/bin/bash

export PROJECT_HOME="$( cd "$(dirname "$0")" ; cd .. ; pwd -P )"
source ${PROJECT_HOME}/scripts/config.sh

${PROJECT_HOME}/scripts/stop_zip.sh

image_count=`/usr/local/bin/docker image ls ${IMAGE_ZIP} --format "{{.ID}}" | wc -l`
if [[ "${image_count}" -gt 0 ]]; then
  for image_id in `/usr/local/bin/docker image ls ${IMAGE_ZIP} --format "{{.ID}}"`
  do
    /usr/local/bin/docker image rm -f ${image_id}
  done
fi

/usr/local/bin/docker image prune --force

/usr/local/bin/docker image build -t ${IMAGE_ZIP}:${VERSION} -f ${PROJECT_HOME}/Dockerfile-zipline ${PROJECT_HOME}

/usr/local/bin/docker image ls ${IMAGE_ZIP}:${VERSION}


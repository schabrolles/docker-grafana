#!/bin/sh
#
# s.chabrolles@fr.ibm.com
#########################

mkdir -p opt/grafana

#docker run --rm -ti -v $PWD/opt:/opt -v $PWD/build_script:/build_script --name grafana2_build schabrolles/ubuntu_ppc64le:15.04 /build_script/build_grafana2.sh
docker run --rm -ti -p 80:80 -v $PWD/opt:/opt -v $PWD/build_script:/build_script --name grafana4_build schabrolles/ubuntu_ppc64le:17.04pre /bin/bash

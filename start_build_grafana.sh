#!/bin/sh
#
# s.chabrolles@fr.ibm.com
#########################
GIT_TAG=$1

if [ -z $GIT_TAG ] ; then
    echo
    echo "WARNING: No GIT TAG version specified, Devlopment version Grafana will be built (could be buggy)."
    echo "https://github.com/grafana/grafana/releases"
    echo "$0 <GIT_TAG>"
    read GIT_TAG
    echo
fi

mkdir -p opt/grafana

docker run --rm --hostname grafana_build -ti -p 80:80 -v $PWD/opt:/opt -v $PWD/build_script:/build_script --name grafana_build ppc64le/ubuntu /build_script/build_grafana.sh $GIT_TAG

[ -f opt/grafana/bin/grafana-server ] && tar zcvf Docker_build/grafana_opt.tar.gz opt || (echo BUILD FAILED && exit 1)


if [ ! -z $GIT_TAG ] ; then
    DOCKER_TAG=$(echo $GIT_TAG | awk -Fv '{ print $NF }')
fi
cd Docker_build
docker build -t schabrolles/grafana_ppc64le . && docker tag schabrolles/grafana_ppc64le schabrolles/grafana_ppc64le:$DOCKER_TAG

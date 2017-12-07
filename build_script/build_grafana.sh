#!/bin/bash
#
# s.chabrolles@fr.ibm.com
# http://docs.grafana.org/project/building_from_source/
#############################################

apt-get update && apt-get -y upgrade

#apt-get install -y git golang curl python phantomjs xvfb
apt-get install -y git build-essential curl python

#curl -sL https://nodejs.org/dist/v6.9.4/node-v6.9.4-linux-ppc64le.tar.xz | tar Jxvf - -C /usr --strip 1
curl -sL https://nodejs.org/download/release/latest-v6.x/node-v6.12.1-linux-ppc64le.tar.xz | tar Jxvf - -C /usr --strip 1
curl -sL https://storage.googleapis.com/golang/go1.8.linux-ppc64le.tar.gz | tar zxvf - -C /usr/local

export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

export GOPATH=/go
[ ! -d $GOPATH ] && mkdir -p $GOPATH

go get github.com/grafana/grafana
cd $GOPATH/src/github.com/grafana/grafana
if [ ! -z $1 ]; then
    git checkout $1
fi

apt-get install -y xvfb
apt-get install -y phantomjs --reinstall

Xvfb :0 -screen 0 1024x768x24 &
export DISPLAY=:0

#npm install phantomjs-prebuilt

npm install -g yarn

#npm install -g grunt grunt-cli

#make all

#yarn install --pure-lockfile
#grunt

#make test

yarn install --pure-lockfile
npm run build

cp -rp bin conf vendor public* /opt/grafana

#!/bin/bash
#
# s.chabrolles@fr.ibm.com
#############################################

apt-get update && apt-get -y upgrade

apt-get install -y git golang curl python phantomjs xvfb

curl -sL https://nodejs.org/dist/v6.9.4/node-v6.9.4-linux-ppc64le.tar.xz | tar Jxvf - -C /usr --strip 1

mkdir /go
export GOPATH=/go
go get github.com/grafana/grafana

export PATH=$PATH:$GOPATH/bin
cd $GOPATH/src/github.com/grafana/grafana
if [ ! -z $1 ]; then
    git checkout $1
fi
Xvfb :0 -screen 0 1024x768x24 &
export DISPLAY=:0

make all
make test

cp -rp bin conf vendor public* /opt/grafana

#!/bin/bash
#
# s.chabrolles@fr.ibm.com
#############################################

apt-get update && apt-get -y upgrade

apt-get install -y git golang nodejs-legacy npm phantomjs xvfb

npm install -g grunt-cli

Xvfb :0 -screen 0 1024x768x24 &
export DISPLAY=:0

mkdir /go
export GOPATH=/go
go get github.com/grafana/grafana

export PATH=$PATH:$GOPATH/bin
cd $GOPATH/src/github.com/grafana/grafana
if [ ! -z $1 ]; then
    git checkout $1
fi

##Building Backend
go run build.go setup
#godep restore
#go build .
go run build.go build
#go run build.go build package --force

##Building frontend assets
npm install -g yarn
yarn install --pure-lockfile
npm run build

#npm install
#npm install -g grunt-cli
#npm rebuild node-sass
#grunt watch
#grunt --force

##Creating optimized release packages
#go run build.go build package

## Install
cp -rp bin conf vendor public* /opt/grafana

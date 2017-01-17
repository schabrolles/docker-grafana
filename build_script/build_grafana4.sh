#!/bin/bash
#
# s.chabrolles@fr.ibm.com
#############################################

apt-get update && apt-get -y upgrade

apt-get install -y git golang wget phantomjs xvfb

curl -sL https://nodejs.org/dist/v6.9.4/node-v6.9.4-linux-ppc64le.tar.xz | tar Jxvf - -C /usr --strip 1

npm install -g grunt grunt-cli yarn

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

echo
echo "Building Grafana Backend"
##Building Backend
go run build.go setup
#godep restore
#go build .
go run build.go build
#go run build.go build package --force

echo
echo "Building Grafana Frontend"
##Building frontend assets
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

FROM node:8.11.3 AS compiler

ENV GRAFANA_VERSION=5.3.0
ENV GO_VERSION=1.9.2
ENV GOROOT=/usr/local/go
ENV PATH=$PATH:$GOROOT/bin
ENV GOPATH=/go

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list && \
    apt-get update ; apt-get install -y git build-essential curl python xvfb phantomjs

RUN Xvfb :0 -screen 0 1024x768x24 &
ENV DISPLAY=:0

RUN curl -sL https://dl.google.com/go/go$GO_VERSION.linux-ppc64le.tar.gz | tar zxvf - -C /usr/local

RUN mkdir -p $GOPATH && \
    go get github.com/grafana/grafana || true

WORKDIR $GOPATH/src/github.com/grafana/grafana
RUN git checkout v$GRAFANA_VERSION 

COPY start_xvfb.sh /start_xvfb.sh

RUN /start_xvfb.sh && make all
RUN mkdir -p /opt/grafana && cp -rp bin conf vendor public* /opt/grafana

##################################################################################################

FROM ubuntu
MAINTAINER s.chabrolles@fr.ibm.com

RUN apt-get update \
&& apt-get install -y libgo7 xvfb ca-certificates phantomjs\
&& rm -rf /var/lib/apt/lists/*

COPY --from=compiler /opt/grafana /opt/grafana

RUN cp /opt/grafana/conf/defaults.ini /opt/grafana/conf/defaults.ini.orig
COPY ./custom.ini /opt/grafana/conf/custom.ini
COPY ./start_all.sh /start_all.sh

VOLUME /opt/grafana/conf
VOLUME /var/lib/grafana

EXPOSE 80

ENV DISPLAY=:0
ENTRYPOINT /start_all.sh
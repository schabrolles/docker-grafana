FROM ppc64le/ubuntu
MAINTAINER s.chabrolles@fr.ibm.com

RUN apt-get update \
&& apt-get install -y libgo7 xvfb ca-certificates phantomjs\
&& rm -rf /var/lib/apt/lists/*

COPY ./grafana_opt.tar.gz /grafana_opt.tar.gz
RUN tar xvf grafana_opt.tar.gz

RUN cp /opt/grafana/conf/defaults.ini /opt/grafana/conf/defaults.ini.orig
COPY ./defaults.ini /opt/grafana/conf/defaults.ini
COPY ./start_all.sh /start_all.sh

VOLUME /opt/grafana/conf
VOLUME /var/lib/grafana

EXPOSE 80

ENV DISPLAY=:0
ENTRYPOINT /start_all.sh

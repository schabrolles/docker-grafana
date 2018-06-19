# Grafana for POWER ppc64le platform.

### Directory where grafana can store logs
`logs = /var/lib/grafana/data/log`

### Directory where grafana will automatically scan and look for plugins
`plugins = /var/lib/grafana/data/plugins`

### Start grafana container
```
docker run -d -p 3000:3000 grafana/grafana
```
Grafana container with persistent storage (recommended)

## create a persistent volume for your data in /var/lib/grafana (database and plugins)

```
docker volume create grafana-storage

# start grafana
docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  -v grafana-storage:/var/lib/grafana \
  grafana/grafana
```

more information here: http://docs.grafana.org/installation/docker/
# docker-grafana

## Building Gafana docker for ppc64le arch
It is not a "fully automated" process as I will need more time in order to do it, and it is not on top of my priority list... Sorry for that.
But If you follow the folling step, you should be able to easily rebuild the latest version of grafana for POWER.

### 1- Clone this repo :
```
git clone https://github.com/schabrolles/docker-grafana.git
```

### 2- Building grafana binaries
```
cd docker-grafana
./start_build_grafana4.sh
```

You will be dropped inside the build-container:
```
cd build_script/
./build_grafana4.sh [<git_tag_from_grafana>]
```
It will build the latest version of grafana available ... it could be a dev version. If you want to build a specific version use a tag (from grafana git) as parameter of `build_grafana4.sh`

Wait until the build process finished (be patient, it is a bit long)

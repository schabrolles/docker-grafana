# docker-grafana for POWER

## Building Gafana docker image for ppc64le arch
It is not a "fully automated" process as I will need more time in order to do it, and it is not on top of my priority list... Sorry for that.
But If you follow the folling step, you should be able to easily rebuild the latest version of grafana for POWER.

### 1- Clone this repo :
On a ppc64le machine, clone this repository.
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
./build_grafana4.sh v4.1.0
```
`./build_grafana4.sh. [grafana git_tag]`
replace `grafana git_tag` with the version you want. This parameter is optional, but if empty, it will build the latest version of grafana available ... it could be a **dev version**. If you want to build a specific version use a tag (from grafana git or check directly [here](https://github.com/grafana/grafana/releases)) as parameter of `build_grafana4.sh`

Wait until the build process finished (be patient, it is a bit long).

When the build is finished, exit from the container with `Ctrl-D`or `exit`.

you should now see a `opt` directory which contain the grafana binaries. Create a tar archive of this directory and put it inside the `Docker_build` directory.
```
tar zcvf Docker_build/grafana4_opt.tar.gz opt
```

### 3- Create docker-grafana container
from the docker-grafana directory, enter in `Docker_build` directory and build the grafana container.
```
cd Docker_build
docker build -t schabrolles/grafana_ppc64le:4.1.0 .
```
adapte `schabrolles/grafana_ppc64le:4.1.0` with your `<repository name>/<image_name>:<tag_version>`.

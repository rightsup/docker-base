This is a simple docker to provide the default environment we run a lot of our apps in.

It includes Ruby lastest stable and is built from [Alpine](http://www.alpinelinux.org/).

Alpine is very lightweight (5mb), And has good [package support](https://pkgs.alpinelinux.org/packages). But not as diverse as Ubuntu So it may be necessary to package or build some libraries and tools. 

Libcouchbase has been packaged for Alpine [here](https://github.com/gerbal/alpine-libcouchbase). Hopefully it will be in the Alpine APK repository soon, but if not we can keep installing it manually. 

The image also includes ruby and a few commonly used utilities.

To use it, replace `FROM ubuntu:14.04` with `FROM rightsup/base`

### UPDATE by Kenan Memis on 08.10.2021 

The new dockerfile, `Dockerfile-ubuntu-20-04` will be used as new base image for some applications like mini-beast

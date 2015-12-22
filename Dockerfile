FROM gliderlabs/alpine:latest
MAINTAINER RightsUp <it@rightsup.com>

# Set Locales to prevent encoding mismatch errors in child containers.
# RUN locale-gen en_US.UTF-8  
# ENV LANG en_US.UTF-8  
# ENV LANGUAGE en_US:en  
# ENV LC_ALL en_US.UTF-8 


RUN apk-install \   
  ## ruby
  ruby \
  ruby-nokogiri \
  ruby-bundler \
  ruby-io-console \
  ruby-bigdecimal \
  ruby-rake \
  ## utils
  bash \
  curl \
  git \
  wget \
  ## build
  autoconf \
  bison \
  ## libraries
  gdbm-dev \
  libev-dev \
  libffi-dev \
  libpq \
  ncurses-dev \
  openssl-dev \
  readline-dev \
  sqlite-libs \
  yaml-dev \
  zlib-dev \
  libstdc++ \
  # build stuff
  cmake \
  build-base

# Ruby Config
ENV CONFIGURE_OPTS --disable-install-doc
RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc
RUN gem update --system
RUN gem install bundler
RUN gem sources -c


# Installs libcouchbase. Used in multiple child services
# Version 2.5.4 Check for updates occasionally. 
# TODO: build apk package, put in Alpine repo
RUN cd /tmp &&  \
    wget http://packages.couchbase.com/clients/c/libcouchbase-2.5.4.tar.gz && \
    ls && \
    tar -xzf libcouchbase-2.5.4.tar.gz && \
    cd libcouchbase-2.5.4 && \
    ./configure.pl && \
    make install && \
    cd / && rm -rf /tmp/*

#Cleanup large build essentials
RUN apk del \
    cmake \
    build-base

CMD bash

FROM gliderlabs/alpine:latest
MAINTAINER RightsUp <it@rightsup.com>

RUN apk-install \   
  ## ruby
  ruby \
  ruby-io-console \
  ruby-bigdecimal \
  ruby-rake \
  ## utils
  bash \
  curl \
  git \
  wget \
  # postgers
  libpq 


# TODO: Replace with apk-install pending acceptance of http://lists.alpinelinux.org/alpine-aports/0128.html
RUN curl -Ls https://github.com/gerbal/alpine-libcouchbase/releases/download/2.5.4/libcouchbase-2.5.4-r0.apk > /tmp/libcouchbase.apk && \ 
    curl -Ls https://github.com/gerbal/alpine-libcouchbase/releases/download/2.5.4/libcouchbase-dev-2.5.4-r0.apk > /tmp/libcouchbase-dev.apk && \ 
    apk-install --allow-untrusted /tmp/libcouchbase.apk /tmp/libcouchbase-dev.apk&& \
    rm /tmp/libcouchbase-dev.apk /tmp/libcouchbase.apk 

# Ruby Config
ENV CONFIGURE_OPTS --disable-install-doc
RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc
RUN gem update --system
RUN gem install bundler
RUN gem sources -c

CMD bash

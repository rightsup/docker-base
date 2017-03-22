FROM ubuntu:14.04
MAINTAINER RightsUp <it@rightsup.com>

# Set Locales to prevent encoding mismatch errors in child containers.
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y \
  autoconf \
  bison \
  curl \
  wget \
  git \
  nano \
  vim \
  tmux \
  g++ \
  postgresql-client \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm3 \
  libgdbm-dev \
  libpq-dev \
  libsqlite3-dev \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  libffi-dev \
  libevent-dev 

# Install Libcouchbase
RUN git clone git://github.com/couchbase/libcouchbase.git && \
  cd libcouchbase && mkdir build && cd build && \
  ../cmake/configure && \
  make && make install

# Install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN git clone https://github.com/sstephenson/rbenv-gem-rehash.git /root/.rbenv/plugins/rbenv-gem-rehash
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> .bashrc

# Install Ruby
ENV RUBY_VERSION 2.3.1
ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install $RUBY_VERSION
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN rbenv global $RUBY_VERSION
RUN gem update --system
RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries

CMD ['bash']

FROM fluent/fluentd:stable-debian-onbuild

# RUN useradd fluent
RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev libcurl4-openssl-dev gnupg2 git" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && sudo gem install \
	fluent-plugin-elasticsearch specific_install \
 && sudo gem specific_install -l 'https://github.com/4hiziri/fluent-plugin-netflow' \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem

EXPOSE 24284 2055

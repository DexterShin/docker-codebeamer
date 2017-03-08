FROM ubuntu:latest

MAINTAINER dextershin <shin@chulho.net>

# Required package
RUN apt-get update && apt-get install -q -y git-core curl sudo xmlstarlet subversion \
  software-properties-common python-software-properties \
  build-essential chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev phantomjs fontconfig fonts-unfonts-core\
  expect libtcnative-1 language-pack-en language-pack-ko cpio\
  && rm -rf /var/lib/apt/lists/*

# Configure locale
RUN dpkg-reconfigure locales 
RUN locale-gen --purge ko_KR.UTF-8
RUN update-locale LANG=ko_KR.UTF-8

# Install Oracle Java 8.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  apt install oracle-java8-set-default

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH $PATH:$JAVA_HOME/bin


# Install codebeamder
# ADD local-installer/CB-${CODEBEAMER_VERSION}-final-linux.bin /opt/codebeamer/cb.bin
RUN mkdir -p /opt/codebeamer
RUN /usr/sbin/useradd --create-home --home-dir /opt/codebeamer --shell /bin/bash codebeamer
RUN curl -o /tmp/cb.bin https://intland.com/wp-content/uploads/2017/03/CB-8.1.0-final-linux.bin 
RUN mv /tmp/cb.bin /opt/codebeamer/ && chmod +x /opt/codebeamer/cb.bin

ADD entrypoint.sh /
ADD install_codebeamer.sh /opt/codebeamer/install_codebeamer.sh

RUN chown codebeamer:codebeamer -R /opt/codebeamer

USER codebeamer
RUN /opt/codebeamer/install_codebeamer.sh


WORKDIR /opt/codebeamer

VOLUME ["/opt/codebeamer"]

EXPOSE 1099 8080 3690

CMD ["/entrypoint.sh"]

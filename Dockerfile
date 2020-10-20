FROM alpine:latest

MAINTAINER Bushidosan

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE="10-20-2020"
ARG VCS_REF
ARG VERSION="5.9"
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Docker image to provide the net-snmp daemon" \
      org.label-schema.description="Provides snmpdv3 for FedoraOS and other small footprint environments without package managers" \
      org.label-schema.vendor="Bushidosan Inc." \

EXPOSE 161 161/udp

RUN apk add --update --no-cache linux-headers alpine-sdk curl findutils sed openssl && \
  mkdir -p /etc/snmp && \
  curl -L "https://sourceforge.net/projects/net-snmp/files/net-snmp/$VERSION/net-snmp-$VERSION.tar.gz/download" -o net-snmp.tgz && \
  tar zxvf net-snmp.tgz && \
  cd net-snmp-* && \
  find . -type f -print0 | xargs -0 sed -i 's/\"\/proc/\"\/host_proc/g' && \
  ./configure --prefix=/usr/local --disable-ipv6 --disable-snmpv1 --disable-snmpv2 --with-defaults && \
  make && \
  make install && \
  cd .. && \
  rm -Rf ./net-snmp* && \
  apk del linux-headers alpine-sdk curl findutils sed

COPY snmpd.conf /etc/snmp
COPY ./docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD [ "/usr/local/sbin/snmpd", "-f", "-c", "/etc/snmp/snmpd.conf" ]

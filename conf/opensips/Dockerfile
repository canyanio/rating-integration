FROM debian:buster-slim

USER root
ENV DEBIAN_FRONTEND noninteractive

ARG VERSION=3.0
ARG BUILD=releases

RUN apt-get update -qq && apt-get install -y gnupg2

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 049AD65B
RUN echo "deb http://apt.opensips.org buster $VERSION-$BUILD" >

RUN apt-get update -qq && apt-get install -y opensips \
opensips-json-module opensips-restclient-module opensips-http-modules

RUN mkdir -p /etc/opensips
ADD opensips.cfg /etc/opensips/opensips.cfg
ADD rating.cfg /etc/opensips/rating.cfg

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]


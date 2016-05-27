FROM byrnedo/alpine-curl

RUN apk add --update bash && rm -rf /var/cache/apk/*

COPY gnatsd /gnatsd
COPY gnatsd.conf /gnatsd.conf
COPY gnatsd.conf.tmp /gnatsd.conf.tmp

ADD gnatsd /gnatsd
ADD gnatsd.conf /gnatsd.conf
ADD gnatsd.conf.tmp /gnatsd.conf.tmp
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV RANCHER_ENABLE=
ENV NATS_USER=
ENV NATS_PASS=
ENV NATS_CLUSTER_USER=ruser
ENV NATS_CLUSTER_PASS=T0pS3cr3t
ENV NATS_CLUSTER_ROUTES=

# Expose client, management, and routing/cluster ports
EXPOSE 4222 8222 6222

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/gnatsd", "-c", "/gnatsd.conf"]

FROM apache/activemq-artemis:2.31.2

ENV ARTEMIS_USER=admin
ENV ARTEMIS_PASSWORD=admin

RUN /opt/apache-artemis/bin/artemis
create /var/lib/artemis-instance \
  --user $ARTEMIS_USER \
  --password $ARTEMIS_PASSWORD \
  --silent \
  --no-secure

WORKDIR /var/lib/artemis-instance

EXPOSE 61616 8161

CMD ["./bin/artemis", "run"]

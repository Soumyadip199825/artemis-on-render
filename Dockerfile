FROM apache/activemq-artemis:2.31.2

ENV ARTEMIS_INSTANCE=/var/lib/artemis-instance
ENV ARTEMIS_USER=admin
ENV ARTEMIS_PASSWORD=admin

WORKDIR $ARTEMIS_INSTANCE

# EXPOSE 61616 8161

CMD ["/opt/apache-artemis/bin/artemis","run"]

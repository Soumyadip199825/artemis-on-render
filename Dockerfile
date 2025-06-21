FROM apache/activemq-artemis:2.31.2

ENV ARTEMIS_INSTANCE=/var/lib/artemis-instance
ENV ARTEMIS_USER=admin
ENV ARTEMIS_PASSWORD=admin

RUN /opt/apache-artemis/bin/artemis create $ARTEMIS_INSTANCE \
--user $ARTEMIS_USER \
--password $ARTEMIS_PASSWORD \
--require-login \
--allow-anonymous

WORKDIR $ARTEMIS_INSTANCE

EXPOSE 61616 8161

CMD ["./bin/artemis","run"]

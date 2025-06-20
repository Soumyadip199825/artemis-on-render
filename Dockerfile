FROM apache/activemq-artemis:2.31.2

ENV ARTEMIS_USER=admin
ENV ARTEMIS_PASSWORD=admin

EXPOSE 61616 8161

CMD ["/opt/apache-artemis/bin/artemis", "run"]

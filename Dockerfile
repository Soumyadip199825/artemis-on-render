FROM apache/activemq-artemis:2.31.2

RUN /opt/apache-artemis/bin/artemis create /var/lib/artemis-instance \
--user admin --password admin --require-login

WORKDIR /var/lib/artemis-instance

# EXPOSE 61616 8161

CMD ["./bin/artemis","run"]

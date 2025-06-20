FROM vromero/activemq-artemis:2.19.0

EXPOSE 61616 8161

CMD ["/docker-entrypoint.sh"]

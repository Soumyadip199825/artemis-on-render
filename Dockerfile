FROM vromero/activemq-artemis:2.31.2-alpine

EXPOSE 61616 8161

CMD ["/docker-entrypoint.sh"]

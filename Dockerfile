# Use a lightweight OpenJDK 17 image as the base
FROM openjdk:17-jdk-slim

# Set environment variables for Artemis version and home directory
ENV ARTEMIS_VERSION=2.34.0
ENV ARTEMIS_HOME=/opt/apache-artemis

# --- Installation Steps ---
# 1. Download Apache ActiveMQ Artemis binary distribution
# 2. Extract it to /opt
# 3. Rename the extracted directory to ARTEMIS_HOME
# 4. Clean up the downloaded archive
RUN wget https://archive.apache.org/dist/activemq/activemq-artemis/${ARTEMIS_VERSION}/apache-artemis-${ARTEMIS_VERSION}-bin.tar.gz -O /tmp/apache-artemis-${ARTEMIS_VERSION}-bin.tar.gz && \
    tar -xzf /tmp/apache-artemis-${ARTEMIS_VERSION}-bin.tar.gz -C /opt && \
    mv /opt/apache-artemis-${ARTEMIS_VERSION} ${ARTEMIS_HOME} && \
    rm /tmp/apache-artemis-${ARTEMIS_VERSION}-bin.tar.gz

# --- Broker Instance Creation ---
# Define the directory for the broker instance
ENV BROKER_INSTANCE_DIR=/var/lib/artemis-instance

# Create the broker instance using Artemis's `create` command.
# This sets up the default directory structure and configuration files.
# --user and --password set the default console login (CHANGE THESE FOR PRODUCTION!)
# --allow-anonymous Y enables anonymous connections (consider setting to N for production)
RUN ${ARTEMIS_HOME}/bin/artemis create --user admin --password admin --allow-anonymous Y ${BROKER_INSTANCE_DIR}

# Ensure the 'artemis' user (created by the 'create' command) owns the instance directory
# This is important for proper permissions when Artemis runs.
RUN chown -R artemis:artemis ${BROKER_INSTANCE_DIR}

# --- Persistent Data Volume ---
# Declare a volume for Artemis's data directory.
# This allows Render to easily attach a persistent disk.
# The `data` subdirectory is where Artemis places its journal files, bindings, etc.
VOLUME ${BROKER_INSTANCE_DIR}/data

# --- Custom Configuration ---
# Copy your custom broker.xml into the broker instance's etc directory.
# This will override the default broker.xml created by the 'artemis create' command.
COPY broker.xml ${BROKER_INSTANCE_DIR}/etc/broker.xml

# --- Network Configuration ---
# Expose the default ports for Artemis messaging protocols and the Hawtio console.
EXPOSE 61616 # Core, AMQP, STOMP, MQTT, OpenWire, HornetQ
EXPOSE 8161 # Hawtio Management Console

# --- Runtime Configuration ---
# Switch to the 'artemis' user for running the broker (good security practice)
USER artemis

# Set the working directory to the broker instance directory
WORKDIR ${BROKER_INSTANCE_DIR}

# Define the command to run the Apache ActiveMQ Artemis broker
CMD ["/var/lib/artemis-instance/bin/artemis", "run"]

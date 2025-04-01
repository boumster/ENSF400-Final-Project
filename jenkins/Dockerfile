FROM jenkins/jenkins:alpine

USER root

# Install Docker and OpenRC
RUN apk add --update docker openrc

# Install necessary plugins
RUN jenkins-plugin-cli --plugins \
    git \
    gradle \
    docker-workflow \
    pipeline-model-definition

# Install Gradle
ENV GRADLE_VERSION=7.6.4
ENV GRADLE_HOME=/opt/gradle
ENV PATH=${GRADLE_HOME}/bin:${PATH}

RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp && \
    unzip -d /opt /tmp/gradle-${GRADLE_VERSION}-bin.zip && \
    ln -s /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} && \
    rm /tmp/gradle-${GRADLE_VERSION}-bin.zip

# Create Gradle directory with correct permissions
RUN mkdir -p /var/jenkins_home/.gradle && \
    chown -R jenkins:jenkins /var/jenkins_home/.gradle && \
    chmod -R 777 /var/jenkins_home/.gradle

# Install necessary plugins
RUN jenkins-plugin-cli --plugins \
    git \
    gradle \
    docker-workflow \
    pipeline-model-definition

USER jenkins
# Expose Jenkins port
EXPOSE 8081
FROM openjdk:11-jdk-slim

WORKDIR /app

# Copy the entire project
COPY . .

# Install required packages, Gradle, and set up Java
RUN apt-get update && \
    apt-get install -y wget unzip && \
    mkdir -p /opt/gradle && \
    wget https://services.gradle.org/distributions/gradle-7.3.3-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-7.3.3-bin.zip && \
    rm /tmp/gradle-7.3.3-bin.zip && \
    mkdir -p /root/.gradle/init.d

# Set environment variables
ENV JAVA_HOME=/usr/local/openjdk-11
ENV GRADLE_HOME=/opt/gradle/gradle-7.3.3
ENV PATH=$PATH:$GRADLE_HOME/bin

# Configure Gradle
RUN echo "org.gradle.java.home=${JAVA_HOME}" >> /root/.gradle/gradle.properties

# Make Gradle wrapper executable and set permissions
RUN chmod +x gradlew && \
    mkdir -p /root/.gradle && \
    chmod -R 777 /root/.gradle

EXPOSE 8080

CMD ["./gradlew", "apprun"]
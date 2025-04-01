# Use OpenJDK 11 as base image
FROM openjdk:11-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project into the container
COPY . .

# Install Gradle (if not available in the image)
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://services.gradle.org/distributions/gradle-7.6.4-bin.zip -P /tmp && \
    unzip /tmp/gradle-7.6.4-bin.zip -d /opt && \
    rm /tmp/gradle-7.6.4-bin.zip && \
    ln -s /opt/gradle-7.6.4/bin/gradle /usr/bin/gradle
#This was necessary on my machine because for some reason my terminal wouldn't find gradle in my machine
# Expose the port used by the application (8080 in this case) to allow external access
EXPOSE 8080

# Make the Gradle wrapper executable
RUN chmod +x gradlew

# Run the application using the Gradle wrapper
CMD ["./gradlew", "apprun"]

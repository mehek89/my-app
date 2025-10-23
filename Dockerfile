# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy built jar file
COPY target/myapp-1.0-SNAPSHOT.jar /app/myapp.jar

# Run the app
ENTRYPOINT ["java", "-jar", "myapp.jar"]

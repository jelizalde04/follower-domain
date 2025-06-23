FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy built JAR file (change name to match your project)
COPY build/libs/add-follower-*.jar app.jar

# Port from your Swagger config
EXPOSE 6001

# Run with production profile and memory limits
ENTRYPOINT ["java", "-jar", "app.jar"]
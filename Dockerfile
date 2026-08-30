# Stage 1: Build Java application with Maven & Jakarta EE Migration
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Download Jakarta EE Migration tool and convert WAR file
ADD https://repo1.maven.org/maven2/org/apache/tomcat/jakartaee-migration/1.0.8/jakartaee-migration-1.0.8-shaded.jar /app/migration.jar
RUN java -jar /app/migration.jar target/BiharYatra.war target/ROOT.war

# Stage 2: Tomcat 10 Production Runtime
FROM tomcat:10.1-jdk17-corretto
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

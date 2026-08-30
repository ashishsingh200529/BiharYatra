FROM tomcat:10.1-jdk17-slim

# Copy converted Jakarta EE WAR file to ROOT webapp
COPY target/BiharYatra-jakarta.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

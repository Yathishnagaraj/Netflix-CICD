FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/NETFLIX-1.2.2.war app.war
ADD https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-runner/9.4.53.v20231009/jetty-runner-9.4.53.v20231009.jar jetty-runner.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","jetty-runner.jar","/app/app.war"]

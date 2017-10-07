FROM openjdk:8-jdk-alpine
RUN apk update && apk upgrade && apk add netcat-openbsd
RUN apk add maven --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
	&& rm -rf /var/cache/apk/*

ENV MAVEN_HOME /usr/share/java/maven-3
ENV PATH $PATH:$MAVEN_HOME/bin
CMD ["mvn", "clean", "package"]
RUN mkdir -p ~/app
RUN ls -la
ADD ./target/docker-hub-automated-build-1.0-SNAPSHOT.jar ~/app/

EXPOSE 8080

CMD ["java", "-jar", "~/app/docker-hub-automated-build-1.0-SNAPSHOT.jar"]

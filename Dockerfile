FROM openjdk:8-jdk-alpine
RUN apk update && apk upgrade && apk add netcat-openbsd
RUN apk add maven --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
	&& rm -rf /var/cache/apk/*

ENV MAVEN_HOME /usr/share/java/maven-3
ENV PATH $PATH:$MAVEN_HOME/bin
ADD . /app
WORKDIR /app

RUN mvn clean package

EXPOSE 8080

ADD . /target/docker-hub-automated-build-1.0-SNAPSHOT.jar

CMD ["java", "-jar", "~/app/target/docker-hub-automated-build-1.0-SNAPSHOT.jar"]

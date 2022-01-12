FROM maven:3.8.3-jdk-11


WORKDIR /build

COPY pom.xml .
RUN mvn org.apache.maven.plugins:maven-dependency-plugin:3.1.1:go-offline
COPY src/ /build/src
COPY bin/run.sh .

VOLUME ["/build/target/gatling/export"]

RUN mvn install --offline
ENTRYPOINT ["./run.sh"]
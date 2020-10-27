FROM maven:3.6.3-openjdk-14-slim as builder

RUN mkdir /build
WORKDIR /build
COPY . .

RUN mvn clean compile test install

FROM adoptopenjdk/openjdk14:alpine-slim
RUN mkdir -p /app /app/config

COPY --from=builder your_app.jar /app/your_app.jar

ENTRYPOINT ["java", "-jar", "/app/your_app.jar"]

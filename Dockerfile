# Étape 1 : Build du JAR avec Maven
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn -B clean package -DskipTests

# Étape 2 : Image finale légère (seulement JRE)
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Sécurité : utilisateur non-root
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copie du JAR depuis l'étape builder
COPY --from=builder /app/target/student-management-0.0.1-SNAPSHOT.jar app.jar

# Port de Spring Boot
EXPOSE 8080

# Lancement
ENTRYPOINT ["java", "-jar", "app.jar"]

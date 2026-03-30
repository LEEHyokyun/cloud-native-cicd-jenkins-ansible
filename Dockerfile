FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

COPY build/libs/cicd-jenkins-ansible-1.jar cicd-jenkins-ansible.jar

VOLUME /tmp

ENTRYPOINT ["java","-jar","cicd-jenkins-ansible.jar"]
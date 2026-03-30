pipeline {
    agent any

    environment {
        //GRADLE_OPTS = "-Dorg.gradle.daemon=false"
        IMAGE_NAME = "leehyokyun/cicd-jenkins-ansible"
        //IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKER_CREDENTIALS_ID = "leehyokyun-cicd-jenkins-ansible-cred"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh './gradlew clean build -x test'
            }
        }

        stage('Test') {
            steps {
                sh './gradlew test'
            }
        }

        stage('Dokcer Build'){
            steps {
                sh """
                docker build -t ${IMAGE_NAME}:latest .
                """
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                        credentialsId: DOCKER_CREDENTIALS_ID,
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push ${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Deploy via Ansible') {
            steps {
                sh """
                ssh root@cloud-native-cicd-ansible-server \
                "ansible-playbook -i /inventory.ini /playbook.yml"
                """
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/build/libs/*.jar', fingerprint: true
        }
        success {
            echo '[Success] Build & Deploy Success'
        }
        failure {
            echo '[Failed] Build or Deploy Failed'
        }
    }
}
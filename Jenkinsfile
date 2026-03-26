pipeline {
    agent any

    environment {
        GRADLE_OPTS = "-Dorg.gradle.daemon=false"
        TOMCAT_CONTAINER = "cloud-native-cicd-tomcat"
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

        stage('Deploy to Tomcat') {
            steps {
                sh '''
                # WAR 파일 찾기
                WAR_FILE=$(ls build/libs/*.war | head -n 1)

                echo "Deploying $WAR_FILE"

                # Tomcat 컨테이너로 복사
                docker cp $WAR_FILE $TOMCAT_CONTAINER:/usr/local/tomcat/webapps/ROOT.war
                '''
            }
        }

        stage('Check Docker Is Active') {
            steps {
                sh 'docker --version || echo "docker CLI not found"'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/build/libs/*.war', fingerprint: true
        }
        success {
            echo '[Success] Build & Deploy Success'
        }
        failure {
            echo '[Failed] Build or Deploy Failed'
        }
    }
}
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                sh '''
                  mvn clean package -DskipTests
                '''
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                                  usernameVariable: 'DOCKER_USER',
                                                  passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                      echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                      IMAGE=${DOCKER_USER}/netflix:3
                      docker build -t $IMAGE .
                      docker push $IMAGE
                    '''
                }
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                  docker rm -f netflix || true
                  IMAGE=yathish047/netflix:3
                  docker run -d --name netflix -p 8080:8080 $IMAGE
                '''
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

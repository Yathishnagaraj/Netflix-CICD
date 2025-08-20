pipeline {
    agent any
    tools { maven 'maven3' }

    environment {
        IMAGE_NAME = "netflix"
    }

    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/Yathishnagaraj/Netflix-CICD.git'
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    def mvnHome = tool name: 'maven3', type: 'maven'
                    sh "${mvnHome}/bin/mvn clean package -DskipTests"
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                      IMAGE=$DOCKER_USER/$IMAGE_NAME:$BUILD_NUMBER
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
                  IMAGE=$DOCKER_USER/$IMAGE_NAME:$BUILD_NUMBER
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

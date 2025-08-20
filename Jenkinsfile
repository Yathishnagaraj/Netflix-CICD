pipeline {
    agent any

    environment {
        IMAGE = "yathish047/netflix:3"
    }

    stages {
        stage('Git Checkout') {
            steps {
                git 'https://github.com/Yathishnagaraj/Netflix-CICD.git'
            }
        }

        stage('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', 
                                  usernameVariable: 'DOCKER_USER', 
                                  passwordVariable: 'DOCKER_PASS')]) {
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                    sh 'docker build -t yathish047/netflix:3 .'
                    sh 'docker push yathish047/netflix:3'
                }
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                    docker rm -f netflix || true
                    docker run -d --name netflix -p 9090:8080 $IMAGE
                '''
            }
        }
    }
}

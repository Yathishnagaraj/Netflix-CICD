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
                withCredentials([string(credentialsId: 'dockerhub-creds', variable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u yathish047 --password-stdin
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
                    docker run -d --name netflix -p 9090:8080 $IMAGE
                '''
            }
        }
    }
}

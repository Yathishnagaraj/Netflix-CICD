Pipeline - Stage 1 & Stage 2 & Stage 3
--------------------------------------------------
pipeline {
    agent any

    tools {
        maven 'maven s/w'
    }

    stages {
        stage('Clone the Code') {
            steps {
                git credentialsId: 'git-creds', url: 'https://github.com/Yathishnagaraj/Netflix-CICD.git'
            }
        }
        stage('Maven Build') {
            steps {
                script {
                    def mavenHome = tool name: 'maven s/w', type: 'maven'
                    def mavenCMD = "${mavenHome}/bin/mvn"
                    // Run Maven build with parallel execution and skip tests if needed
                    sh "${mavenCMD} clean package -T 1C -DskipTests"
                }
            }
        }
        stage('Deployment Stage') {
            steps {
                script {
                    // Ensure target directory exists before copying
                    sh 'ls -l target'
                    // Deploy the WAR file to Tomcat
                    sh 'sudo cp target/NETFLIX-1.2.2.war /root/apache-tomcat-9.0.93/webapps'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up after build...'
            cleanWs() // Clean workspace after build
        }
    }
}

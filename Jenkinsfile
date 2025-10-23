pipeline {
    agent any

    environment {
        // Jenkins Credentials IDs
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials-id' // replace with your Docker Hub credential ID
        GIT_CREDENTIALS = 'git-credentials-id'             // replace with your Git credential ID
        IMAGE_NAME = "mehek08/my-app:latest"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git(
                    url: 'https://github.com/mehek89/my-app.git',
                    branch: 'main',
                    credentialsId: "${GIT_CREDENTIALS}"
                )
            }
        }

        stage('Build Java App') {
            steps {
                // Make sure Maven is configured in Jenkins global tools
                tool name: 'Maven3', type: 'maven'
                bat 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}",
                                                  passwordVariable: 'DOCKERHUB_PSW',
                                                  usernameVariable: 'DOCKERHUB_USR')]) {
                    bat 'docker login -u %DOCKERHUB_USR% -p %DOCKERHUB_PSW%'
                    bat "docker push ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline Failed!"
        }
    }
}

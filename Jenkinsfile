pipeline {
    agent any

    environment {
        // Docker image name
        IMAGE_NAME = "mydockerapp"
        IMAGE_TAG = "latest"
        // Set your credentials ID for GitHub
        GIT_CREDENTIALS_ID = "9547ac26-588c-4feb-b618-8e7aa2603a83"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                git(
                    url: 'https://github.com/mehek89/my-app.git',
                    branch: 'main',
                    credentialsId: "${GIT_CREDENTIALS_ID}"
                )
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                script {
                    docker.image("${IMAGE_NAME}:${IMAGE_TAG}").run("-d -p 8082:8080 --name myappcontainer")
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
        always {
            echo 'Cleaning up dangling Docker images...'
            script {
                sh "docker image prune -f"
            }
        }
    }
}

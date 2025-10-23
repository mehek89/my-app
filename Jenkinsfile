pipeline {
    agent any

    environment {
        // Docker image name and tag
        IMAGE_NAME = "mydockerapp"
        IMAGE_TAG = "latest"
        // GitHub credentials ID
        GIT_CREDENTIALS_ID = "9547ac26-37d9-45f6-a338-6abc6d8c914e"
        // Docker container name
        CONTAINER_NAME = "myappcontainer"
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
                bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Stop Old Container') {
            steps {
                echo 'Stopping any existing container...'
                // Stop if exists, ignore errors
                bat """
                if exist ${CONTAINER_NAME} (
                    docker stop ${CONTAINER_NAME} || echo Container not running
                    docker rm ${CONTAINER_NAME} || echo Container not removed
                )
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                bat "docker run -d -p 8082:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${IMAGE_TAG}"
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
            bat "docker image prune -f"
        }
    }
}

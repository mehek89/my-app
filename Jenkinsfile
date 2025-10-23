pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'mehek08'
        DOCKER_PASSWORD = credentials('dockerhub-creds') // Jenkins Docker Hub credentials
        GIT_USERNAME = 'mehek89'
        GIT_PASSWORD = credentials('git-credentials-id') // Jenkins Git credentials
        DOCKER_PATH = '"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe"' // Full Docker path
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'main',
                    credentialsId: 'git-credentials-id',
                    url: 'https://github.com/mehek89/my-app.git'
            }
        }

        stage('Verify Tools') {
            steps {
                echo 'Checking Maven version...'
                bat 'mvn -v'

                echo 'Checking Docker version...'
                bat "${DOCKER_PATH} --version"
            }
        }

        stage('Build Java App') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "${DOCKER_PATH} build -t %DOCKER_USERNAME%/my-app:latest ."
            }
        }

        stage('Push Docker Image') {
            steps {
                bat """
                    echo %DOCKER_PASSWORD% | ${DOCKER_PATH} login -u %DOCKER_USERNAME% --password-stdin
                    ${DOCKER_PATH} push %DOCKER_USERNAME%/my-app:latest
                """
            }
        }
    }

    post {
        success {
            echo 'Pipeline Succeeded!'
        }
        failure {
            echo 'Pipeline Failed!'
        }
    }
}

pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds') // Docker Hub credential ID
        GIT_USERNAME = 'mehek89'
        DOCKER_USERNAME = 'mehek08'
    }

    tools {
        maven 'Maven3' // Must match Jenkins Global Tool Configuration
    }

    stages {
        stage('Verify Tools') {
            steps {
                echo 'Checking Maven version...'
                bat 'mvn -v'
                echo 'Checking Docker version...'
                bat 'docker --version'
            }
        }

        stage('Checkout SCM') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/mehek89/my-app.git',
                    credentialsId: '' // Add if repo is private
            }
        }

        stage('Build Java App') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_USERNAME%/my-app:latest ."
            }
        }

        stage('Push Docker Image') {
            steps {
                bat "docker login -u %DOCKER_USERNAME% -p %DOCKERHUB_CREDENTIALS_PSW%"
                bat "docker push %DOCKER_USERNAME%/my-app:latest"
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline Failed!'
        }
    }
}

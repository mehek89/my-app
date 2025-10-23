pipeline {
    agent any
    tools {
        maven 'Maven3'   // Name of Maven in Jenkins Global Tool Configuration
        jdk 'JDK21'      // Name of JDK in Jenkins Global Tool Configuration
    }
    environment {
        // Docker Hub credentials added in Jenkins → Credentials
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }
    stages {
        stage('Checkout Source') {
            steps {
                // Clone your GitHub repo using HTTPS and credentials
                git branch: 'main',
                    url: 'https://github.com/mehek89/my-app.git',
                    credentialsId: 'git-credentials-id' // Add your GitHub PAT here in Jenkins Credentials
            }
        }
        stage('Build Java App') {
            steps {
                bat 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t mehek08/my-app:latest .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                // Login to Docker Hub using Jenkins credentials
                bat 'docker login -u %DOCKERHUB_CREDENTIALS_USR% -p %DOCKERHUB_CREDENTIALS_PSW%'
                bat 'docker push mehek08/my-app:latest'
            }
        }
    }
    post {
        always {
            echo 'Pipeline finished'
        }
        success {
            echo 'Build and Docker Push Successful!'
        }
        failure {
            echo 'Pipeline Failed!'
        }
    }
}

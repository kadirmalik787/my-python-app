pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'kadirmalik457/python-app'
        DOCKER_TAG = 'latest'
        DOCKER_CREDS = credentials('docker-hub-creds')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/kadirmalik787/my-python-app.git', 
                     branch: 'main'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        
        stage('Test Docker Image') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'python --version'
                        sh 'python app.py'
                    }
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                retry(3) {
                    script {
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-creds') {
                            dockerImage.push()
                        }
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline completed - check Docker Hub for your image!'
            // Remove slackSend if not configured
        }
    }
}

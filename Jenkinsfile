pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'kadirmalik457/python-app'
        DOCKER_TAG = 'latest'
        // Store Docker Hub credentials in Jenkins (Manage Jenkins > Credentials)
        DOCKER_CREDS = credentials('docker-hub-creds')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/kadirmalik787/my-python-app.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build using the Dockerfile in your repo
                    dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        
        stage('Test Docker Image') {
            steps {
                script {
                    // Run the container to verify it works
                    dockerImage.inside {
                        sh 'python --version'
                        sh 'python app.py'
                    }
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                        dockerImage.push()
                        dockerImage.push("${DOCKER_TAG}")
                    }
                }
            }
        }
        
        stage('Cleanup') {
            steps {
                script {
                    // Remove built image to save space
                    sh 'docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG} || true'
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline completed - check Docker Hub for your image!'
        }
        success {
            slackSend channel: '#jenkins',
                     message: "SUCCESS: ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
        }
        failure {
            slackSend channel: '#jenkins',
                     message: "FAILED: ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
        }
    }
}

pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'kadirmalik457/21-04'
    }

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/kadirmalik787/my-python-app.git'
            }
        }

        stage('Run App') {
            steps {
                sh 'python app.py'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
    }
}

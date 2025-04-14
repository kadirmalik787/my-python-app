pipeline {
    agent {
        docker { image 'python:3.10' }
    }
    stages {
        stage('Show Python Version') {
            steps {
                sh 'python --version'
            }
        }

        stage('Run Python App') {
            steps {
                sh 'python app.py'
            }
        }
    }
}

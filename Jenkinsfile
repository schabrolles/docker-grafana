pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building ...'
                sh 'uname -a'
            }
        }
        stage('Test') {
            steps {
                echo 'Test1'
                echo 'Test2'
            }
        }
        stage('Deploying') {
            steps {
                echo 'Deploying ...'
            }
        }
    }
}
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building ...'
                sh 'docker build -t schabrolles/grafana_ppc64le:latest .'
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
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh './jenkins/scripts/build.sh'
            }
        }
        stage('Deliver') {
            steps {
                sh './jenkins/scripts/deploy.sh'
            }
        }
    }
}

pipeline {
    agent {
        docker {
            label "docker-xsmall"
            image 'node:alpine'
            args '-p 3000:3000'
        }
    }
    stages {
        stage('Build') {
            steps {
                // sh './jenkins/scripts/build.sh'
                sh "npm install"
                sh "npm install -g gitbook-cli"
                sh "gitbook install"
                sh "gitbook build"
            }
        }
        stage('Deploy') {
            steps {
                // sh './jenkins/scripts/deploy.sh'
                echo "Deploy here"
            }
        }
    }
}

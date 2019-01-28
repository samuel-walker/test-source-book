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
                sh '''
                    npm install
                    npm config set unsafe-perm true
                    npm install some_package
                    npm install -g gitbook-cli
                    gitbook install
                    gitbook build
                    npm config set unsafe-perm false
                '''.trim()
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

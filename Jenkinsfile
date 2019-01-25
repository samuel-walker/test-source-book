pipeline {
    agent {
        docker {
            image 'node:-alpine'
            args '-p 3000:3000'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                    npm install
                    npm install -g gitbook-cli
                    gitbook install
                    gitbook build
                '''
            }
        }
    }
}

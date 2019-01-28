pipeline {
    agent {
        dockerfile {
            label "docker-small"
            args '-p 3000:3000'
        }
    }
    stages {
        stage('Build') {
            steps {
                // ideally remove config step (different agent?)
                sh '''
                    npm install
                    npm config set unsafe-perm true
                    npm install -g gitbook-cli
                    gitbook install
                    gitbook build
                    npm config set unsafe-perm false
                '''.trim()
            }
        }
        stage('Deploy') {
            steps {
                withAwsCli(credentialsId: 'gitbook-testing', defaultRegion: 'us-east-1') {
                    // Copy book directory to S3
                    sh "aws s3 cp ./_book s3://gitbook-testing.s3-website-us-east-1.amazonaws.com/test-source-book --recursive"
                }
            }
        }
    }
}

pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    label "docker-xsmall"
                    image 'node:alpine'
                }
            }
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
            agent {
                docker {
                    // label "docker-xsmall"
                    image 'mesosphere/aws-cli:latest'
                    // args  "--entrypoint='' "
                    reuseNode true
                }
            }
            steps {
                withAwsCli(credentialsId: 'gitbook-testing', defaultRegion: 'us-east-1') {
                    // Copy book directory to S3
                    sh "aws s3 cp ./_book s3://gitbook-testing.s3-website-us-east-1.amazonaws.com/test-source-book --recursive"
                }
            }
        }
    }
}

pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    label "docker-xsmall"
                    image 'nikolaik/python-nodejs'
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
                    ls
                '''.trim()
                echo "Stashing book"
                stash includes: '_book/**', name: 'book'
            }
        }
        stage('Deploy') {
            agent {
                docker {
                    label "docker-xsmall"
                    image 'nikolaik/python-nodejs'
                    reuseNode true
                }
            }
            steps {
                echo "Unstashing book"
                unstash('book')
                echo "Testing build"
                sh "ls"
                echo "Testing dependencies"
                sh "python --version"
                sh "pip --version"
                sh "pip install awscli"
                sh "aws --version"
                echo "Starting S3 upload"
                withAwsCli(credentialsId: 'gitbook-testing', defaultRegion: 'us-east-1') {
                    // Copy book directory to S3
                    sh "aws s3 cp _book s3://gitbook-testing/test-source-book/ --acl public-read --recursive"
                }
            }
        }
    }
}

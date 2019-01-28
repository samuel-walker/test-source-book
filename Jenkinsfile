pipeline {
    agent {
        docker {
            label "docker-small"
            image 'node:alpine'
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
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'gitbook-testing']]) {
                    // Install awscli
                    sh '''
                    apt install python-pip python-dev build-essential
                    pip install --upgrade pip
                    '''
                    // Copy book directory to S3
                    sh "aws s3 cp _book s3://gitbook-testing.s3-website-us-east-1.amazonaws.com/test-source-book --recursive"
                }
                // withAwsCli(credentialsId: 'gitbook-testing', defaultRegion: 'us-east-1') {
                //     // Copy book directory to S3
                //     sh "aws s3 cp ./_book s3://gitbook-testing.s3-website-us-east-1.amazonaws.com/test-source-book --recursive"
                // }
            }
        }
    }
}

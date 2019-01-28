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
                    npm install -g gitbook-cli
                    gitbook install
                    gitbook build
                    npm config set unsafe-perm false
                '''.trim()
            }
        }
        stage('Deploy') {
            steps {
                // Install awscli
                sh '''
                wget http://security.ubuntu.com/ubuntu/pool/main/a/apt/apt_1.0.1ubuntu2.19_amd64.deb -O apt.deb
                sudo dpkg -i apt.deb
                apt-get install python-pip python-dev build-essential
                pip install --upgrade pip
                '''.trim()
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'gitbook-testing']]) {
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

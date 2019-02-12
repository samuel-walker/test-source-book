pipeline {
    agent {
        dockerfile {
            label "docker-xsmall"
        }
    }
    stages {
        stage('Prepare') {
            steps {
                // fetch npm dependencies from package.json
                sh 'npm install -q'
            }
        }
        stage('Build') {
            steps {
                echo "Building GitBook"
                sh "gitbook build"

                echo "Generating PDF"
                sh "gitbook pdf ./ ${env.BRANCH_NAME}.pdf"

            }
        }
        stage('Deploy') {
            steps {
                echo "Starting S3 upload"
                withAwsCli(credentialsId: 'gitbook-testing', defaultRegion: 'us-east-1') {
                    // Copy book directory to S3
                    sh "aws s3 cp _book s3://gitbook-testing/${env.BRANCH_NAME} --acl public-read --recursive"
                }
            }
        }
    }
}
